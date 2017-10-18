//
//  BugseeReport.h
//  Bugsee
//
//  Created by Dmitry Fink on 8/25/16.
//  Copyright © 2016 Bugsee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BugseeConstants.h"

@interface BugseeReport : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic) BugseeSeverityLevel severity;

@end
