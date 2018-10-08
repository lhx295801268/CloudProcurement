#import "UIDevice+MC.h"
#import "sys/utsname.h"
#import "spawn.h"
#include <sys/param.h>
#include <sys/mount.h>
@implementation UIDevice (MC)

+ (NSString *)deviceResolution
{
    static NSString *resolution = nil;
    if (resolution == nil) {
        resolution = [NSString stringWithFormat:@"%.0f*%.0f",
                      [[UIScreen mainScreen] bounds].size.width*[UIScreen mainScreen].scale,
                      [[UIScreen mainScreen] bounds].size.height*[UIScreen mainScreen].scale];
    }
    return resolution;
}


+ (NSString*)deviceName
{
    static NSString *curDevice = nil;
    if (curDevice == nil) {
        struct utsname systemInfo;
        uname(&systemInfo);
        
        curDevice = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    return curDevice;
}

+ (NSString *)deviceModel
{
    return [UIDevice currentDevice].model;
}

+ (BOOL)isRetina
{
    return [UIScreen mainScreen].scale == 2;
}

static const char * __jb_app = NULL;
+ (BOOL)isJailBroken NS_AVAILABLE_IOS(4_0)
{
    static const char * __jb_apps[] =
    {
        "/Application/Cydia.app",
        "/Application/limera1n.app",
        "/Application/greenpois0n.app",
        "/Application/blackra1n.app",
        "/Application/blacksn0w.app",
        "/Application/redsn0w.app",
        NULL
    };
    __jb_app = NULL;
    // method 1
    for ( int i = 0; __jb_apps[i]; ++i ) {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )  {
            __jb_app = __jb_apps[i];
            return YES;
        }
    }
    
    // method 2
    if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)jailBreaker NS_AVAILABLE_IOS(4_0)
{
    if ( __jb_app ) {
        return [NSString stringWithUTF8String:__jb_app];
    }
    return @"";
}

+ (BOOL)isDevicePhone
{
    NSString * deviceType = [UIDevice currentDevice].model;
    
    if ( [deviceType rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch].length > 0 ||
        [deviceType rangeOfString:@"iPod" options:NSCaseInsensitiveSearch].length > 0 ||
        [deviceType rangeOfString:@"iTouch" options:NSCaseInsensitiveSearch].length > 0 )  {
        return YES;
    }
    return NO;
}

+ (BOOL)isDevicePad
{
    
    NSString * deviceType = [UIDevice currentDevice].model;
    
    if ( [deviceType rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0 ) {
        return YES;
    }
    return NO;
}

+ (BOOL)requiresPhoneOS
{
    return [[[NSBundle mainBundle].infoDictionary objectForKey:@"LSRequiresIPhoneOS"] boolValue];
}

+ (BOOL)isPhone
{
    if ([self isPhone35] || [self isPhoneRetina35] || [self isPhoneRetina4])  {
        return YES;
    }
    return NO;
}

+ (BOOL)isIphoneX
{
    return [self isScreenSize:CGSizeMake(1125, 2436)];
}
+(BOOL)isIphoneXOrLater{
    if ([self judgeIphoneType] >= kYCIphoneTypeForX) {
        return YES;
    }
    return NO;
}

+ (BOOL)isScreen35
{
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPhone35
{
    if ([self isDevicePad]) {
        if ([self requiresPhoneOS] && [self isPad]) {
            return YES;
        }
        return NO;
    }  else {
        return [self isScreenSize:CGSizeMake(320, 480)];
    }
}

+ (BOOL)isPhoneRetina35
{
    if ( [self isDevicePad] ) {
        if ( [self requiresPhoneOS] && [self isPadRetina] ) {
            return YES;
        }
        return NO;
    } else {
        return [self isScreenSize:CGSizeMake(640, 960)];
    }
}

+ (BOOL)isPhoneRetina4
{
    if ( [self isDevicePad])  {
        return NO;
    } else {
        return [self isScreenSize:CGSizeMake(640, 1136)];
    }
}

+ (BOOL)isPad
{
    return [self isScreenSize:CGSizeMake(768, 1024)];
}

+ (BOOL)isPadRetina
{
    return [self isScreenSize:CGSizeMake(1536, 2048)];
}

+ (BOOL)isScreenSize:(CGSize)size
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        CGSize size2 = CGSizeMake( size.height, size.width );
        CGSize screenSize = [UIScreen mainScreen].currentMode.size;
        
        if (CGSizeEqualToSize(size, screenSize) || CGSizeEqualToSize(size2, screenSize)) {
            return YES;
        }
    }
    return NO;
}


//////////////////
+ (float)floatVersion
{
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
}


- (long long)diskSpaceLeft
{
    NSArray* thePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    const char *path = [[NSFileManager defaultManager] fileSystemRepresentationWithPath:[thePath lastObject]];
    statfs(path, &tStats);
    long long freespace = (long long)(tStats.f_bavail * tStats.f_bsize);
    return freespace;
}

+(YCIphoneType)judgeIphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"]) {
        return kYCIphoneTypeFor4;
    }else if([platform isEqualToString:@"iPhone4,1"]){
        return kYCIphoneTypeFor4S;
    }else if([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]){
        return kYCIphoneTypeFor5;
    }else if([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]){
        return kYCIphoneTypeFor5C;
    }else if([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]){
        return kYCIphoneTypeFor5S;
    }else if([platform isEqualToString:@"iPhone7,2"]){
        return kYCIphoneTypeFor6;
    }else if([platform isEqualToString:@"iPhone7,1"]){
        return kYCIphoneTypeFor6P;
    }else if([platform isEqualToString:@"iPhone8,1"]){
        return kYCIphoneTypeFor6S;
    }else if([platform isEqualToString:@"iPhone8,2"]){
        return kYCIphoneTypeFor6SP;
    }else if([platform isEqualToString:@"iPhone8,4"]){
        return kYCIphoneTypeForSE;
    }else if([platform isEqualToString:@"iPhone9,1"] || [platform isEqualToString:@"iPhone9,3"]){
        return kYCIphoneTypeFor7;
    }else if([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"]){
        return kYCIphoneTypeFor7P;
    }else if([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"]){
        return kYCIphoneTypeFor8;
    }else if([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"]){
        return kYCIphoneTypeFor8P;
    }else if([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]){
        return kYCIphoneTypeForX;
    }else if([platform isEqualToString:@"iPhone11,8"]){
        return kYCIphoneTypeForXR;
    }else if([platform isEqualToString:@"iPhone11,2"]){
        return kYCIphoneTypeForXS;
    }else if([platform isEqualToString:@"iPhone11,6"]){
        return kYCIphoneTypeForXSM;
    }else{
        return kYCIphoneTypeForNormal;
    }
}
@end
