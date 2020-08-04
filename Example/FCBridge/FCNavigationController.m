//
//  HSNavigationController.m

//

#import "FCNavigationController.h"

@interface FCNavigationController ()

@end

@implementation FCNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = nil;
}

///**
// * 可以在这个方法中拦截所有push进来的控制器
// */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
//        //        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 40)];
//        //
//        //        // 设置左上角 反回按键 图片 和 高亮状态颜色
//        //        [button setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
//        //        [button setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateHighlighted];
//        //        //button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0 );
//        //        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        //
//        //        UIBarButtonItem *backBtnI = [[UIBarButtonItem alloc] initWithCustomView:button];
//        //        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//        //
//        //                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//        //
//        //                                           target:nil action:nil];
//        //
//        //        negativeSpacer.width = -30;
//        //
//
//    }
//
//    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
//    [super pushViewController:viewController animated:animated];
//
//}
//
//- (void)back
//{
//    [self popViewControllerAnimated:YES];
//}

@end
