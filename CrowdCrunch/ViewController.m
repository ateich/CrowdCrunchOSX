//
//  ViewController.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "ViewController.h"
#import "Project.h"
#import "PathTransformer.h"

@implementation ViewController
@synthesize projects;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TEST: %@", collectionView);
    NSCollectionViewItem *proto = [self.storyboard instantiateControllerWithIdentifier:@"projectItemView"];
    [collectionView setItemPrototype:proto];
    
    id transformer = [[PathTransformer alloc] init];
    [NSValueTransformer setValueTransformer:transformer forName:@"PathTransformer"];

    
    // Do any additional setup after loading the view.
    Project * pm1 = [[Project alloc] init];
    pm1.title = @"John Appleseed";
    pm1.text = @"Doctor";
    pm1.image = @"fibre-optic.jpg";
    pm1.subscribed = @"NO";
    
    Project * pm2 = [[Project alloc] init];
    pm2.title = @"Jane Carson";
    pm2.text = @"Teacher";
    pm2.image = @"fibre-optic.jpg";
    pm2.subscribed = @"YES";
    
    Project * pm3 = [[Project alloc] init];
    pm3.title = @"Ben Alexander";
    pm3.text = @"Student";
    pm3.image = @"fibre-optic.jpg";
    pm3.subscribed = @"NO";
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithObjects:pm1, pm2, pm3, nil];
    [self setPersonModelArray:tempArray];
    [collectionView setContent:projects];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

//KVO Compliant Functions
-(void)insertObject:(Project *)p
inPersonModelArrayAtIndex:(NSUInteger)index {
    [projects insertObject:p atIndex:index];
}
-(void)removeObjectFromPersonModelArrayAtIndex:(NSUInteger)index {
    [projects removeObjectAtIndex:index];
}
-(void)setPersonModelArray:(NSMutableArray *)a {
    projects = a;
}
-(NSArray*)projects {
    return projects;
}

//Other
- (void)awakeFromNib {
    
}

@end
