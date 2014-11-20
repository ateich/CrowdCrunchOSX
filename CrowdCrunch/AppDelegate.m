//
//  AppDelegate.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "AppDelegate.h"
#import <IOKit/ps/IOPowerSources.h>
#import "SettingsViewController.h"


@interface AppDelegate (){
    NSString *path;
    NSMutableDictionary *data;
    SettingsViewController *settingsVC;
    int batteryThreshold;
    bool run_vm_on_battery;
    bool run_only_during_hours;
    
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self getSettingsPlist];
    
    //run a bash script call startDocker in the Resources folder (wherever that is)
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"startDocker" ofType:@"sh"], nil]];
    [task launch];
    [self initializePowerSourceChanges];
    
    if(!batteryThreshold){
        batteryThreshold = [[data objectForKey:@"stop when battery reaches"] intValue];
    }
    
    if(!run_vm_on_battery){
        run_vm_on_battery = [[data objectForKey:@"run on battery power"] boolValue];
    }
    
    //Get the current time in hours and minutes (24 hour scale)
    NSString *currentTime = [self getCurrentLocalTime];
    NSRange colonLocation = [currentTime rangeOfString:@":"];
    int hour = [[currentTime substringToIndex:colonLocation.location] intValue];
    int minutes = [[currentTime substringFromIndex:colonLocation.location+1] intValue];
    NSLog(@"NOW: %i : %i", hour, minutes);
    
    //Get day of week
    NSLog(@"Day of Week: %@", [self getDayOfWeek]);
}

-(NSString*)getCurrentLocalTime{
    NSDateFormatter *timeOfDayInt = [[NSDateFormatter alloc] init];
    [timeOfDayInt setDateFormat:@"HH:mm"];
    return [timeOfDayInt stringFromDate:[NSDate date]];
}

-(NSString*)getDayOfWeek{
    NSDateFormatter *dayOfWeek = [[NSDateFormatter alloc] init];
    [dayOfWeek setDateFormat:@"EEEE"];
    return [dayOfWeek stringFromDate:[NSDate date]];
}

-(void)setActiveSettingsView:(SettingsViewController *)settingsViewController{
    settingsVC = settingsViewController;
}
-(void)setBatteryThreshold:(int)batteryPercentage{
    batteryThreshold = batteryPercentage;
}
-(void)setRunOnBattery:(bool)runOnBattery{
    run_vm_on_battery = runOnBattery;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [data writeToFile: path atomically:YES];
}

//Set Setting
-(void)setSetting:(NSString *)key :(id)val{
    [data setObject:val forKey:key];
}

//Get Setting
-(id)getSetting:(NSString *)key{
    NSLog(@"data: %@", data);
    return [data objectForKey:key];
}

//Get Settings.plist
-(void)getSettingsPlist{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    } else {
//        [fileManager removeItemAtPath:path error:nil];
    }
    
    data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
}

//Battery Status
-(int)getBatteryPercentage{
    NSLog(@ "POWER SOURCES: %@", IOPSCopyPowerSourcesInfo());
    return 0;
}

-(void)setBatteryVariables{
    CFTypeRef source = IOPSCopyPowerSourcesInfo();
    CFArrayRef sources = IOPSCopyPowerSourcesList(source);
    
    NSDictionary *batteryDetails = CFBridgingRelease(IOPSGetPowerSourceDescription(source, sources));
    NSLog(@"%@", batteryDetails);
    NSString *powerSource = [[batteryDetails valueForKey:@"Power Source State"] objectAtIndex:0];
    int batteryPercentageRemaining = [[[batteryDetails valueForKey:@"Current Capacity"] objectAtIndex:0] intValue];
    
    bool runVM = NO;
    
    if(run_vm_on_battery){
        NSLog(@"OK TO RUN ON BATTERY POWER");
        //RUN VM
        runVM = YES;
    } else if([powerSource isEqual: @"AC Power"]){
        NSLog(@"ON AC POWER");
        //RUN VM
        runVM = YES;
    }
    
    if(batteryPercentageRemaining <= batteryThreshold){
        NSLog(@"BELOW BATTERY THRESHOLD (%i) - DO NOT RUN", batteryThreshold);
        //STOP VM
        runVM = NO;
    }
    
    if(runVM){
        //start VM
        NSLog(@"RUNNING VM");
    } else {
        //stop VM
        NSLog(@"STOPPING VM");
    }
}

void PowerSourcesHaveChanged(void *context){
    NSLog(@"battery status changed");
    
    //    [self doThisPlease]; // <- self undeclared
    //update battery percentage and status (plugged in or not)
    id callbackObject = (__bridge id) context;
    [callbackObject setBatteryVariables];
}

/* initializePowerSourceChanges
 *
 * Registers a handler that gets called on power source (battery or UPS)
 changes
 */
-(void)initializePowerSourceChanges
{
    CFRunLoopSourceRef         CFrls;
    
    // Create and add RunLoopSource
    CFrls =
    IOPSNotificationCreateRunLoopSource(PowerSourcesHaveChanged, (__bridge void *)self);
    if(CFrls) {
        CFRunLoopAddSource(CFRunLoopGetCurrent(), CFrls,
                           kCFRunLoopDefaultMode);
        CFRelease(CFrls);
    }
    
}

@end
