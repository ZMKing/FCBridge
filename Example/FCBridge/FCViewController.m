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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转web" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 200, 200, 200);
    [btn addTarget:self action:@selector(toWebBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backNavigation) name:@"h5JumpNavigationBack" object:nil];
 
}

- (void)backNavigation{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toWebBtn {
    
    
    TestWebViewController *testC = [[TestWebViewController alloc]   initWithURLString:@"http://175.24.11.42:10015/"];
    
       [self.navigationController pushViewController:testC animated:YES];
}



@end
