#import <dlfcn.h>
#import <UIKit/UIKit.h>
#include <notify.h>
#include <objc/message.h>
#import "FLEXManager.h"

@interface UIStatusBarWindow : UIWindow @end

__attribute__((visibility("hidden")))
@interface AutoFLEX : NSObject {
@private
}
@end

@implementation AutoFLEX

+ (instancetype)sharedInstance
{
    static AutoFLEX *_sharedFactory;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedFactory = [[self alloc] init];
    });

    return _sharedFactory;
}

- (id)init
{
    self = [super init];
    return self;
}

-(void)inject {
	NSLog(@"Openning explorer: %@", [FLEXManager sharedManager]);
	[[FLEXManager sharedManager] showExplorer];
}
@end

%hook UIStatusBarWindow
- (id)initWithFrame:(CGRect)frame {
    self = %orig;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(inject:)]];
    return self;
}

-(void) inject: (UILongPressGestureRecognizer*)lges {
    [[FLEXManager sharedManager] showExplorer];
}
%end

%ctor {
    [[NSNotificationCenter defaultCenter] addObserver:[AutoFLEX sharedInstance] selector:@selector(inject) name:UIApplicationDidBecomeActiveNotification object:nil];
}
