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
#warning add by lhx 20181007 判断等待后面添加
+(BOOL)isIphoneXOrLater{
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

@end
