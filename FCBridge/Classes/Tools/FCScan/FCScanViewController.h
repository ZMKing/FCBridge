
#import <UIKit/UIKit.h>
#import "FCConst.h"

@interface FCScanViewController : UIViewController

/** 扫描结果 */
@property (nonatomic, copy) void (^returnScanBarCodeValue)(NSString * barCodeString);

@end
