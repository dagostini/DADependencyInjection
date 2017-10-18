//
//  BugseeLogger.h
//  Bugsee
//
//  Created by ANDREY KOVALEV on 29.11.15.
//  Copyright © 2016 Bugsee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BugseeLumberjackLogger (id <DDLogger>)[BugseeLogger sharedInstance]
#define BugseeReactNativeLogger [[BugseeLogger sharedInstance] reactNativeLogger]

typedef void (^BugseeRCTLogFunction)(
    NSInteger level,
    NSInteger source,
    NSString *fileName,
    NSNumber *lineNumber,
    NSString *message
);

typedef enum : NSUInteger {
    BugseeLogLevelInvalid = 0,
    BugseeLogLevelError,
    BugseeLogLevelWarning,
    BugseeLogLevelInfo,
    BugseeLogLevelDebug,
    BugseeLogLevelVerbose
} BugseeLogLevel;

@interface BugseeLogger : NSObject 

+ (instancetype) sharedInstance;
+(void) install;

@property (nonatomic, strong) id logFormatter;
@property (copy) BugseeRCTLogFunction reactNativeLogger;

@end


