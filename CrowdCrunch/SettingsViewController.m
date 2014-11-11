//
//  SettingsViewController.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@implementation SettingsViewController{
    AppDelegate *appDelegate;
    NSMutableDictionary *days;
}
//@synthesize projects;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load existing settings
    appDelegate = [[NSApplication sharedApplication] delegate];
    
    int runOnBatteryPower = [[appDelegate getSetting:@"run on battery power"] intValue];
    if(runOnBatteryPower != 0){
        [runOnBattery setSelectedSegment:0];
    } else {
        [runOnBattery setSelectedSegment:1];
    }
    
    int runOnlyDuringHoursValue = [[appDelegate getSetting:@"run only during hours"] intValue];
    if(runOnlyDuringHoursValue != 0){
        [runOnlyDuringHours setSelectedSegment:0];
    } else {
        [runOnlyDuringHours setSelectedSegment:1];
    }
    
    days = [appDelegate getSetting:@"run on days"];
    
    for(id day in days){
        [days objectForKey:day]; // on or off (0 || 1)
        if([day isEqualTo:@"Sunday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:0];
        } else if([day isEqualTo:@"Monday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:1];
        } else if([day isEqualTo:@"Tuesday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:2];
        } else if([day isEqualTo:@"Wednesday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:3];
        } else if([day isEqualTo:@"Thursday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:4];
        } else if([day isEqualTo:@"Friday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:5];
        } else if([day isEqualTo:@"Saturday"]){
            [runDays setSelected:[[days objectForKey:day] boolValue] forSegment:6];
        }
    }
    
    [stopAtBatteryPercentage setStringValue:[[appDelegate getSetting:@"stop when battery reaches"] stringValue]];
    [runHoursStart setStringValue:[appDelegate getSetting:@"run hours start"]];
    [runHoursEnd setStringValue:[appDelegate getSetting:@"run hours end"]];
    
    
    //Set segmented control listeners
    [runOnBattery setAction:@selector(runOnBatteryChanged:)];
    [runOnlyDuringHours setAction:@selector(runOnlyDuringHoursChanged:)];
    [runDays setAction:@selector(runDaysChanged:)];
    
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
//    NSLog(@"%@: stringValue == %@", [textField identifier],[textField stringValue]);
    
    if([[textField identifier] isEqual: @"batteryPercentage"]){
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        [appDelegate setSetting:@"stop when battery reaches" :[f numberFromString:[textField stringValue]]];
    } else if([[textField identifier] isEqual: @"startTime"]){
        [appDelegate setSetting:@"run hours start" :[textField stringValue]];
    } else if([[textField identifier] isEqual: @"endTime"]){
        [appDelegate setSetting:@"run hours end" :[textField stringValue]];
    }
}

- (IBAction)runOnBatteryChanged:(id)sender
{
    long clickedSegment = [sender selectedSegment];
    if(clickedSegment == 0){
        [appDelegate setSetting:@"run on battery power" :[NSNumber numberWithBool:YES]];
    } else {
        [appDelegate setSetting:@"run on battery power" :[NSNumber numberWithBool:NO]];
    }
}

- (IBAction)runOnlyDuringHoursChanged:(id)sender
{
    long clickedSegment = [sender selectedSegment];
    if(clickedSegment == 0){
        [appDelegate setSetting:@"run only during hours" :[NSNumber numberWithBool:YES]];
    } else {
        [appDelegate setSetting:@"run only during hours" :[NSNumber numberWithBool:NO]];
    }
}

- (IBAction)runDaysChanged:(id)sender
{
    long clickedSegment = [sender selectedSegment];
    BOOL isSelected = [runDays isSelectedForSegment:clickedSegment];
    NSLog(isSelected ? @"On" : @"Off");
    switch (clickedSegment) {
        case 0:
            NSLog(@"SUNDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Sunday"];
            break;
        case 1:
            NSLog(@"MONDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Monday"];
            break;
        case 2:
            NSLog(@"TUESDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Tuesday"];
            break;
        case 3:
            NSLog(@"WEDNESDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Wednesday"];
            break;
        case 4:
            NSLog(@"THURSDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Thursday"];
            break;
        case 5:
            NSLog(@"FRIDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Friday"];
            break;
        case 6:
            NSLog(@"SATURDAY");
            [days setValue:[NSNumber numberWithBool:isSelected] forKey:@"Saturday"];
            break;
            
        default:
            break;
    }
    [appDelegate setSetting:@"run on days" :days];
    [runDays setSelected:isSelected forSegment:clickedSegment];
    NSLog([runDays isSelectedForSegment:clickedSegment] ? @"YES" : @"NO");
}


@end

