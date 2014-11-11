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

    //GET projects from server
    NSURL *projectsURL = [NSURL URLWithString:@"http://mtcolt.herokuapp.com/api/projects"];
    NSMutableArray *projectsData = [self getProjects:projectsURL];
    
//    // Do any additional setup after loading the view.
//    Project * pm1 = [[Project alloc] init];
//    pm1.title = @"John Appleseed";
//    pm1.text = @"Doctor";
//    pm1.image = @"fibre-optic.jpg";
//    pm1.subscribed = @"NO";
//    
//    Project * pm2 = [[Project alloc] init];
//    pm2.title = @"Jane Carson";
//    pm2.text = @"Teacher";
//    pm2.image = @"fibre-optic.jpg";
//    pm2.subscribed = @"YES";
//    
//    Project * pm3 = [[Project alloc] init];
//    pm3.title = @"Ben Alexander";
//    pm3.text = @"Student";
//    pm3.image = @"fibre-optic.jpg";
//    pm3.subscribed = @"NO";
//    
//    NSMutableArray * tempArray = [NSMutableArray arrayWithObjects:pm1, pm2, pm3, nil];
//    
//    //TEMP FOR TESTING
//    for (int i=0; i<20; i++) {
//        Project * pmTemp = [[Project alloc] init];
//        pmTemp.title = @"Ben Alexander";
//        pmTemp.text = @"Student";
//        pmTemp.image = @"fibre-optic.jpg";
//        pmTemp.subscribed = @"NO";
//        [tempArray addObject:pmTemp];
//    }
    
    
//    [self setPersonModelArray:tempArray];
    [self setPersonModelArray:projectsData];
    [collectionView setContent:projects];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

//GET projects from server
- (NSMutableArray *)getProjects:(NSURL *)url{
    //make http request
    NSData *data = [self dataWithUrl:url];
    
    //TEST
    NSString *test = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"TEST: %@", test);
    //END TEST
    
    //parse JSON data
    NSError *e = nil;
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: kNilOptions error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        for(NSDictionary *item in jsonArray) {
            NSLog(@"Item: %@", item);
        }
    }
    
    return jsonArray;
}

//HTTP REQUEST
- (NSData *)dataWithUrl:(NSURL *)url
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:30];
    [urlRequest setHTTPMethod:@"GET"];
    
    // Fetch the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    NSLog(@"URL DATA: %@", urlData);
    
    // Construct a String around the Data from the response
    return urlData;
    //return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
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
