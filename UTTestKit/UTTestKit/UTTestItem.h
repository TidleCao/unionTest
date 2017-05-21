//
//  UTTestItem.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTErrors.h"

typedef NS_ENUM(NSUInteger, UTTestState) {
    UTTestStateIDLE,
    UTTestStateTesting,
    UTTestStatePausing,
    UTTestStatePaused,
    UTTestStateFinished,
    UTTestStateAborting,
    UTTestStateAborted
};

typedef NS_ENUM(NSUInteger, UTTestResult) {
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


@class UTTestAction;
@class UTTestItem;

// MARK: - UTTestItemDelegate
@protocol UTTestItemDelegate <NSObject>

@required
- (BOOL)testItem:(UTTestItem*)testItem shouldStartTestAction:(UTTestAction*)testAction;

@optional
- (void)testItem:(UTTestItem*)testItem willStartTestAciotn:(UTTestAction*)testAction;
- (void)testItem:(UTTestItem*)testItem didFinishTestAction:(UTTestAction *)testAction;

@end

// MARK: - UTTestItem

@interface UTTestItem : NSObject

@property (weak) id<UTTestItemDelegate> delegate;

@property (readonly) UTTestResult result;
@property (readonly) UTTestState state;

@property UTLimit limit;
@property UTMeasureType measureType;
@property (nonatomic,retain,readwrite) id measureValue;

@property (retain) NSMutableArray<UTTestAction *> *actions;

// 开始测试
- (UTErrorType)runTest;

// 暂停停止
- (void)stopTest;

// 放弃测试
- (void)abortTest;

// 恢复暂停的测试
- (void)resumeTest;
@end


