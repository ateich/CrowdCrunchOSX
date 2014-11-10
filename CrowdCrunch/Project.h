//
//  Project.h
//  TEST
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Project : NSObject {
    NSString *title;
    NSString *text;
    NSString *subscribed;
    NSString *image;
}

@property (retain, readwrite) NSString *title;
@property (retain, readwrite) NSString *text;
@property (retain, readwrite) NSString *subscribed;
@property (retain, readwrite) NSString *image;


@end
