//
//  BugseeAttachment.h
//  Bugsee
//
//  Created by ANDREY KOVALEV on 14.07.16.
//  Copyright © 2016 Bugsee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BugseeAttachment : NSObject

+(nullable instancetype) attachmentWithName:(nonnull NSString*)name filename:(nonnull NSString*)filename data:(nonnull NSData *)data;

@property (nonnull, nonatomic, strong) NSString *name;
@property (nonnull, nonatomic, strong) NSString *filename;
@property (nonnull, nonatomic, strong) NSData *data;

@end
