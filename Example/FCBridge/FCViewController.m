//
//  FCViewController.m
//  FCBridge
//
//  Created by ZMKing on 06/23/2020.
//  Copyright (c) 2020 ZMKing. All rights reserved.
//

#import "FCViewController.h"
#import "TestWebViewController.h"



@interface FCViewController ()

@end

@implementation FCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib. https://www.shuimuchangxiang.com/location.html  http://175.24.11.42:10015/
    
    TestWebViewController *testC = [[TestWebViewController alloc]   initWithURLString:@"http://175.24.11.42:10015/"];
    testC.view.frame = self.view.bounds;
    
    [self addChildViewController:testC];
    [self.view addSubview:testC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toWebViewBtn:(id)sender {
    
    
   
    
   // [self presentViewController:testC animated:YES completion:nil];
    
}

@end
