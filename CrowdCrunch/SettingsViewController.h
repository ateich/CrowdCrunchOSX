//
//  SettingsViewController.h
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsViewController : NSViewController {
    IBOutlet NSSegmentedControl *runOnBattery;
    IBOutlet NSSegmentedControl *runOnlyDuringHours;
    IBOutlet NSSegmentedControl *runDays;
    IBOutlet NSTextField *stopAtBatteryPercentage;
    IBOutlet NSTextField *runHoursStart;
    IBOutlet NSTextField *runHoursEnd;
}

//@property (readwrite, strong, nonatomic) NSMutableArray *projects;


@end
