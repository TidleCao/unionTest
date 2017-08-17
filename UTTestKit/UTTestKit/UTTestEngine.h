//
//  UTTestEngine.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTestItem.h"
#import "UTErrors.h"

// MARK: - UTTestEngine

@class UTTestEngine;

@protocol UTTestEngineDelegate <NSObject>

@required
- (BOOL)shouldStartTestEngine: (UTTestEngine *)engine;
- (BOOL)testEngine:(UTTestEngine *)engine shouldStartTestItem: (UTTestItem*)testItem;

@optional

- (void)willStartTestEngine:(UTTestEngine *)engine;
- (void)testEngine:(UTTestEngine *)engine willStartTestItem:(UTTestItem *)testItem;
- (void)testEngine:(UTTestEngine *)engine willStopTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine willAbortTestItem:(UTTestItem*)testItem;

- (void)testEngine:(UTTestEngine *)engine didFinishTestItem:(UTTestItem *)testItem;
- (void)testEngine:(UTTestEngine *)engine didStopTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine didAbortTestItem:(UTTestItem*)testItem;
- (void)didFinishTestEngine:(UTTestEngine *)engine;

@end

@interface UTContext : NSObject

@property NSMutableDictionary *localVariables;
@property NSMutableDictionary *globalVariables;
@property NSPredicate *loopCondition;

@end

// MARK: - UTTestEngine

@interface UTTestEngine : NSObject
@property (weak) id<UTTestEngineDelegate> delegate;
@property (readonly) UTTestState state;
@property (retain) UTContext *context;
@property (retain) NSMutableArray<UTTestItem *> *testItems;

- (UTErrorType)startTest;

// 暂停后可以继续测试下去
- (UTErrorType)stopTest;

// 放弃测试后不可继续测试
- (UTErrorType)abortTest;

@end


