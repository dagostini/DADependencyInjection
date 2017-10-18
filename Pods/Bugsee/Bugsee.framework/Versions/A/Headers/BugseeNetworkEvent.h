//
//  BugseeNetworkEvent.h
//  Bugsee
//
//  Created by ANDREY KOVALEV on 22.07.16.
//  Copyright © 2016 Bugsee. All rights reserved.
//

#import <Foundation/Foundation.h>

// Used to pass this class to decisionBlock() as complition handler
// in bugseeFilterNetworkEvent:completionHandler: delegate
// see documentation page to learn more https://docs.bugsee.com/sdk/ios/privacy/

typedef enum : NSUInteger {
    BugseeNetwork,
    BugseeWebSocket
} BugseeNetworkType;

@interface BugseeNetworkEvent : NSObject

+ (instancetype _Nonnull )eventWithID:(NSString *_Nonnull)ID
                 HTTPmethod:(NSString *_Nullable) method
                       type:(BugseeNetworkType) networkType
            bugseeEventType:(NSString *_Nullable) eventType
                        url:(NSString *_Nullable) urlStr
              redirectedUrl:(NSString *_Nullable) redirectedUrl
                       body:(NSData *_Nullable)body
                      error:(NSDictionary*_Nullable)error
                    headers:(NSDictionary*_Nullable)headers
               noBodyReason:(NSString*_Nullable)noBodyReason
                   dataSize:(int64_t)dataSize
               responseCode:(NSInteger)responseCode;

@property (nonatomic, strong) NSString * _Nullable ID;
/**
 *  BugseeNetwork, BugseeWebSocket
 */
@property (nonatomic, assign) BugseeNetworkType type;
/**
 *  Network event URL
 */
@property (nonatomic, strong, nullable) NSString * url;
/**
 *  URL of Network event that we were redirected from
 */
@property (nonatomic, strong, nullable) NSString * redirectedFromURL;

/**
 *  Raw body of the request or response were available.
 */
@property (nonatomic, strong, nullable) NSData * body;
@property (nonatomic, strong, nullable) NSDictionary * error;
/**
 *  HTTP headers
 */
@property (nonatomic, strong, nullable) NSDictionary * headers;

/**
 *  Http request method
 */
@property (nonatomic, strong, nonnull) NSString * method;
@property (nonatomic, strong, nullable) NSString * noBodyReason;
@property (nonatomic, assign) int64_t dataSize;

/**
 *  Can be one of 
 *  BugseeNetworkEventBegin, BugseeNetworkEventComplete, BugseeNetworkEventCancel or BugseeNetworkEventError
 *  or WebSocket event with types
 *  BugseeWebSocketEventOpen, BugseeWebSocketEventSend, BugseeWebSocketEventMessage, BugseeWebSocketEventClose, BugseeWebSocketEventError;
 *  @see BugseeConstants
 */
@property (nonatomic, strong, nonnull) NSString * bugseeNetworkEventType;

/**
 *  Status code of current response, always 0 for BugseeNetworkEventBegin
 *  Can't be modified
 */
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, assign) BOOL override;
@property (nonatomic, assign) NSTimeInterval timestamp;


@property (nonatomic, assign, readonly) BOOL urlChanged;
@property (nonatomic, assign, readonly) BOOL rURLChanged;
@property (nonatomic, assign, readonly) BOOL bodyChanged;
@property (nonatomic, assign, readonly) BOOL errorChanged;
@property (nonatomic, assign, readonly) BOOL headersChanged;

@end
