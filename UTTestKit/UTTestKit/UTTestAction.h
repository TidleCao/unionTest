//
//  UTTestAction.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UTType) {
    UTTypeVoid    = 0,
    UTTypeNumber  = 1,
    UTTypeString  = 2,
    UTTypeObject  = 3
};

@interface UTTestAction : NSObject
@property UTType returnType;
@property id target;
@property SEL action;
@property (readonly) id returnValue;
@property NSDictionary *params;
@property NSDictionary *context;

- (void)execute;

@end
NS_ASSUME_NONNULL_END
