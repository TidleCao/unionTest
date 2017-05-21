//
//  UTTestItem.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UTTestResult) {
    UTTestResultPending = 0,  // 测试中
    UTTestResultPassed  = 1,  // 测试Passed
    UTTestResultFailed  = 2   // 测试failed
};

typedef NS_ENUM(NSUInteger, UTMeasureType) {
    UTMeasureTypeNone   = 0, // 不判断
    UTMeasureTypeLimit  = 1, // 判断范围
    UTMeasureTypeBool   = 2, // 判断结果是否为真
    UTMeasureTypeEqual  = 3, // 判断结果是否相当等
};

typedef struct {
    double uppperLimit;
    double lowerLimit;
}UTLimit;

@interface UTTestItem : NSObject

@property (readonly) UTTestResult result;
@property UTLimit limit;
@property UTMeasureType measureType;
@property (nonatomic,retain,readwrite) id measureValue;

@end
