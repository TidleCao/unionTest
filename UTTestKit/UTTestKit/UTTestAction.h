//
//  UTTestAction.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, UTType) {
    UTTypeVoid    = 0,
    UTTypeNumber  = 1,
    UTTypeString  = 2,
    UTTypeObject  = 3
};

@interface UTTestAction : NSObject
@property UTType returnType;
@property (readonly) id returnValue;

- (void)execute;

@end
