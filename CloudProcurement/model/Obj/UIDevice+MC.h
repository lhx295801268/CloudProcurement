#import <UIKit/UIKit.h>

@interface UIDevice (MC)


+ (NSString *)deviceModel;
+ (NSString *)deviceResolution;
+ (NSString *)deviceName;

// 是否retina屏
+ (BOOL)isRetina;

// 是否越狱
+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;

+ (BOOL)requiresPhoneOS;

+ (BOOL)isIphoneX;
+(BOOL)isIphoneXOrLater;
//如果是3.5寸屏
+ (BOOL)isScreen35;
+ (BOOL)isPhone;
+ (BOOL)isPhone35;
+ (BOOL)isPhoneRetina35;
+ (BOOL)isPhoneRetina4;
+ (BOOL)isPad;
+ (BOOL)isPadRetina;
+ (BOOL)isScreenSize:(CGSize)size;

//////////////////////////////
///返回ios设备磁盘剩余空间，字节byte
- (long long)diskSpaceLeft;
@end
