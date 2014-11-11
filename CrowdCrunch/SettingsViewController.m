//
//  SettingsViewController.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "SettingsViewController.h"
@implementation SettingsViewController
//@synthesize projects;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set listeners
    [runOnBattery setAction:@selector(runOnBatteryChanged:)];
    [runOnlyDuringHours setAction:@selector(runOnlyDuringHoursChanged:)];
    [runDays setAction:@selector(runDaysChanged:)];
    [stopAtBatteryPercentage setAction:@selector(stopAtBatteryPercentageChanged:)];
    [runHoursStart setAction:@selector(runHoursStartChanged:)];
    [runHoursEnd setAction:@selector(runHoursEndChanged:)];
    
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
//    NSLog(@"%@: stringValue == %@", [textField identifier],[textField stringValue]);
    
    if([[textField identifier] isEqual: @"batteryPercentage"]){
        NSLog(@"1");
    } else if([[textField identifier] isEqual: @"startTime"]){
        NSLog(@"2");
    } else if([[textField identifier] isEqual: @"endTime"]){
        NSLog(@"3");
    }
}

- (IBAction)runOnBatteryChanged:(id)sender
{
    long clickedSegment = [sender selectedSegment];
    if(clickedSegment == 0){
        NSLog(@"ON");
    } else {
        NSLog(@"OFF");
    }
}

- (IBAction)runOnlyDuringHoursChanged:(id)sender
{
    long clickedSegment = [sender selectedSegment];
    if(clickedSegment == 0){
        NSLog(@"ON");
    } else {
        NSLog(@"OFF");
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
            break;
        case 1:
            NSLog(@"MONDAY");
            break;
        case 2:
            NSLog(@"TUESDAY");
            break;
        case 3:
            NSLog(@"WEDNESDAY");
            break;
        case 4:
            NSLog(@"THURSDAY");
            break;
        case 5:
            NSLog(@"FRIDAY");
            break;
        case 6:
            NSLog(@"SATURDAY");
            break;
            
        default:
            break;
    }
}


@end

