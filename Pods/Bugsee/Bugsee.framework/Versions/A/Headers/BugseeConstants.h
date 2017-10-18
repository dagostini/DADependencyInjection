//
//  BugseeConstants.h
//  Bugsee
//
//  Created by ANDREY KOVALEV on 10.06.16.
//  Copyright © 2016 Bugsee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BugseeAttachment.h"

#define BugseeTrue @(YES)
#define BugseeFalse @(NO)

@class BugseeNetworkEvent;
typedef void (^BugseeNetworkFilterDecisionBlock)(BugseeNetworkEvent * _Nullable event );
typedef void (^BugseeAttachmentsDecisionBlock)(NSArray<BugseeAttachment*>* _Nullable attachments);
typedef void (^BugseeNetworkEventFilterBlock)(BugseeNetworkEvent * _Nonnull event, BugseeNetworkFilterDecisionBlock _Nonnull decisionBlock);

typedef enum : NSUInteger {
    BugseeSeverityLow = 1,
    BugseeSeverityMedium = 2,
    BugseeSeverityHigh = 3,
    BugseeSeverityCritical = 4,
    BugseeSeverityBlocker = 5
} BugseeSeverityLevel;

typedef enum : NSUInteger {
    BugseeFrameRateLow = 1,
    BugseeFrameRateMedium = 2,
    BugseeFrameRateHigh = 3
} BugseeFrameRate;

/**
 *  BugseeStyleBasedOnStatusBarStyle setup style by current status bar style
 *  BugseeStyleDark when you have UIStatusBarStyleLightContent and BugseeStyleDefault when you have UIStatusBarStyleDefault
 */
extern NSString *const _Nonnull BugseeStyleDefault,
                *const _Nonnull BugseeStyleDark,
                *const _Nonnull BugseeStyleBasedOnStatusBarStyle
;

extern NSString *const _Nonnull BugseeShakeToReportKey,
                *const _Nonnull BugseeMaxRecordingTimeKey,
                *const _Nonnull BugseeScreenshotToReportKey,
                *const _Nonnull BugseeCrashReportKey,
                *const _Nonnull BugseeKillDetectionKey,
                *const _Nonnull BugseeFrameRateKey,
                *const _Nonnull BugseeMaxFrameRateKey,
                *const _Nonnull BugseeMinFrameRateKey,
                *const _Nonnull BugseeMonitorNetworkKey,
                *const _Nonnull BugseeMonitorWebSocketKey,
                *const _Nonnull BugseeStatusBarInfoKey,
                *const _Nonnull BugseeVideoEnabledKey,
                *const _Nonnull BugseeStyleKey,
                *const _Nonnull BugseeEnableMachExceptionsKey,
                *const _Nonnull BugseeReportPrioritySelectorKey,
                *const _Nonnull BugseeDefaultCrashPriorityKey,
                *const _Nonnull BugseeDefaultBugPriorityKey,
                *const _Nonnull BugseeCaptureLogsKey
;

/**
 *  We can only show you request/response bodies with size less than 5 kb
 */
extern NSString *const _Nonnull BugseeNetworkBodySizeTooLarge;

/**
 *  We support json, text and xml formats
 */
extern NSString *const _Nonnull BugseeNetworkBodyUnsupportedContentType;

/**
 *  No content type on request/response
 */
extern NSString *const _Nonnull BugseeNetworkBodyNoContentType;

/**
 *  We support data only in UTF8 string encoding
 */
extern NSString *const _Nonnull BugseeNetworkBodyCantReadData;

//Network event types, this constants are used in BugseeNetworkEvent bugseeNetworkEventType property.
//see documentation page to learn more https://docs.bugsee.com/sdk/ios/privacy/

extern NSString * const _Nonnull BugseeNetworkEventBegin;
extern NSString * const _Nonnull BugseeNetworkEventComplete;
extern NSString * const _Nonnull BugseeNetworkEventCancel;
extern NSString * const _Nonnull BugseeNetworkEventError;

extern NSString * const _Nonnull BugseeWebSocketEventOpen;
extern NSString * const _Nonnull BugseeWebSocketEventSend;
extern NSString * const _Nonnull BugseeWebSocketEventMessage;
extern NSString * const _Nonnull BugseeWebSocketEventClose;
extern NSString * const _Nonnull BugseeWebSocketEventError;

extern NSString * const _Nonnull BugseeReportTypeBug;
extern NSString * const _Nonnull BugseeReportTypeCrash;
extern NSString * const _Nonnull BugseeReportTypeError;
