/**
 *  直接填写小数
 */
#define FCDecimalColor(r, g, b, a)    [UIColor colorWithRed:r green:g blue:b alpha:a]

/**
 *  直接填写整数
 */
#define FCColor(r, g, b, a)    [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]

/**
 *  随机颜色
 */
#define FCRandom    FCColor(arc4random() % 256, arc4random() % 256, arc4random() % 256, 1)

#define FCBlack         [UIColor blackColor]
#define FCDarkGray      [UIColor darkGrayColor]
#define FCLightGray     [UIColor lightGrayColor]
#define FCWhite         [UIColor whiteColor]
#define FCGray          [UIColor grayColor]
#define FCRed           [UIColor redColor]
#define FCGreen         [UIColor greenColor]
#define FCBlue          [UIColor blueColor]
#define FCCyan          [UIColor cyanColor]
#define FCYellow        [UIColor yellowColor]
#define FCMagenta       [UIColor magentaColor]
#define FCOrange        [UIColor orangeColor]
#define FCPurple        [UIColor purpleColor]
#define FCBrown         [UIColor brownColor]
#define FCClear         [UIColor clearColor]
#define FCSkyBlue       FCDecimalColor(0, 0.68, 1, 1)
#define FCLightBlue     FCColor(125, 231, 255, 1)
#define FCFicelle       FCColor(247, 247, 247, 1)
#define FCTaupe         FCColor(238, 239, 241, 1)
#define FCTaupe2        FCColor(237, 236, 236, 1)
#define FCGrassGreen    FCColor(254, 200, 122, 1)
#define FCGold          FCColor(255, 215, 0, 1)
#define FCDeepPink      FCColor(238, 18, 137, 1)
