//
//  XDPUIProxy.h
//  SEEXiaodianpu
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 全面屏
#define kXDPiPhoneBottomSafeAreaHeight [TIoTUIProxy shareUIProxy].tabbarAddHeight

// screen
#define kScreenWidth [TIoTUIProxy shareUIProxy].screenWidth
#define kScreenHeight [TIoTUIProxy shareUIProxy].screenHeight
#define kScreenAllWidthScale [TIoTUIProxy shareUIProxy].screenAllWidthScale
#define kScreenAllHeightScale [TIoTUIProxy shareUIProxy].screenAllHeightScale

//rgb
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)

//navigation
#define kXDPNavigationBarIcon 30
#define kXDPNavigationBarTitleColor kRGBColor(0,0,0)
#define kXDPNavigationBarTitleFont 18
#define kXDPNavigationBackgroundColor [UIColor whiteColor]
#define kXDPNavigationLineColor kRGBColor(230,230,230)
#define kXDPNavigationBarHeight [TIoTUIProxy shareUIProxy].navigationBarHeight

//tabbar
#define kXDPTabbarTintColor kRGBColor(51,51,51)
#define kXDPTabbarNomalColor kRGBColor(51,51,51)
#define kXDPTabbarBackgroundColor [UIColor whiteColor]
#define kXDPTabbarTitleFont 11
#define kXDPTabbarHeight [TIoTUIProxy shareUIProxy].tabbarHeight
//tabbar 线颜色
#define kXDPTabbarLineColor kRGBAColor(0,0,0,0.1)

//edge
#define kHorEdge 16
#define kXDPContentRealWidth [TIoTUIProxy shareUIProxy].contentWidth

//主题色
#define kMainColor kRGBColor(0, 82, 217)
#define kMainColorDisable kRGBAColor(0, 82, 217, 0.2)
#define kWarnColor kRGBColor(229, 69, 69)
#define kWarnColorDisable kRGBAColor(229, 69, 69, 0.2)
//线颜色
#define kLineColor kRGBColor(242, 244, 245)
//字体颜色
#define kFontColor kRGBColor(51, 51, 51)
//背景颜色
#define kBgColor [UIColor whiteColor]
//背景颜色
#define kBackgroundHexColor @"#F5F5F5"
//红色
#define kSignoutHexColor @"#FA5151"
//温度字体颜色
#define kTemperatureHexColor @"#15161A"
//时区地区字体颜色
#define kIndexFontHexColor @"#006EFF"  //kRGBColor(0, 110, 255)
//智能模块蓝色
#define kIntelligentMainHexColor @"#0066FF" // (0,125,255)
//警告颜色
#define kWarnHexColor @"#E54545"
//按钮不可点击灰色
#define kNoSelectedHexColor @"#D6D8DC"
//注册/登录区域提示文字颜色
#define kRegionHexColor @"#6C7078"
//注册/登录 手机号邮箱文字颜色
#define kPhoneEmailHexColor @"#A1A7B2"
//tabbar自定义视图添加设备入口按钮背景色
#define kAddDeviceEntrance @"#E1E2E5"
//输入框错误红色提示
#define kInputErrorTipHexColor @"#FF0000"
//添加设备页面深蓝色
#define kAddDeviceSignHexColor @"#0052D9"

#define COLOR_F2F2F2 @"#F2F2F2"
#define COLOR_016EFF @"#016EFF"
#define COLOR_000000 @"#000000"
#define COLOR_A1A7B2 @"#A1A7B2"

#define WeakObj(o) __weak typeof(o) o##Weak = o;
#define StrongObj(o) __strong typeof(o) o##strong = o##Weak;

//判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])

typedef NS_ENUM(NSInteger,WCThemeStyle) {
    WCThemeSimple,
    WCThemeStandard,
    WCThemeDark,
};


typedef NS_ENUM(NSInteger, TIoTConfigHardwareStyle) {
    TIoTConfigHardwareStyleSmartConfig = 0,
    TIoTConfigHardwareStyleSoftAP = 1,
    TIoTConfigHardwareStyleLLsync = 2
};


NS_ASSUME_NONNULL_BEGIN

@interface TIoTUIProxy : NSObject

+ (TIoTUIProxy *)shareUIProxy;


/**
 以widht 375pt 为标准(不含p的放大)
 @return 比例
 */
@property (nonatomic , assign) CGFloat screenWidthScale;
/**
 以widht 375pt 为标准(含p的放大)
 @return 比例
 */
@property (nonatomic , assign) CGFloat screenAllWidthScale;
/**
 以height 375pt 为标准(含p的放大)
 @return 比例
 */
@property(nonatomic, assign) CGFloat screenAllHeightScale;

@property (nonatomic , assign) CGSize screenSize;
@property (nonatomic , assign) CGFloat screenWidth;
@property (nonatomic , assign) CGFloat screenHeight;

@property (nonatomic , assign) CGFloat contentWidth;

// 是否iPhoneX
@property (nonatomic , assign) BOOL iPhoneX;

// tab高度(包括全面屏)
@property (nonatomic , assign) CGFloat tabbarHeight;
// 全面屏增加的高度
@property (nonatomic , assign) CGFloat tabbarAddHeight;
// 状态栏高度（包括全面屏）
@property (nonatomic , assign) CGFloat statusHeight;
// 导航栏高度
@property (nonatomic , assign) CGFloat navigationBarHeight;

+ (UIColor *)colorWithHexColor:(NSString *)hexColor alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
