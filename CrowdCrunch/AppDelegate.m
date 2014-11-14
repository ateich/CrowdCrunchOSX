//
//  AppDelegate.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    NSString *path;
    NSMutableDictionary *data;
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
    }
    
    data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
}

@end
