//
//  UTTestEngine.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UTTestState) {
    UTTestStateIDLE,
    UTTestStateTesting,
    UTTestStateFinished,
    UTTestStateAborting,
    UTTestStateAborted
};

typedef NS_ENUM(NSUInteger, UTErrorType) {
    UTErrorTypeNoError,
};


// MARK: - UTTestEngine
@class UTTestEngine;
@class UTTestItem;
@class UTTestAction;

@protocol UTTestEngineDelegate <NSObject>

- (BOOL)shouldStartTestEngine: (UTTestEngine *)engine;
- (BOOL)testEngine:(UTTestEngine *)engine shouldStartTestItem: (UTTestItem*)testItem;
- (BOOL)testEngine:(UTTestEngine *)engine shouldStartTestAction:(UTTestAction*)testAction forTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine willStartTestAciotn:(UTTestAction*)testAction forTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine didFinishTestAction:(UTTestAction *)testAction forTestItem:(UTTestItem *)testItem;
- (void)testEngine:(UTTestEngine *)engine willStopTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine didStopTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine willAbortTestItem:(UTTestItem*)testItem;
- (void)testEngine:(UTTestEngine *)engine didAbortTestItem:(UTTestItem*)testItem;
- (void)willStartTestEngine:(UTTestEngine *)engine;
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
- (UTErrorType)stopTest;
- (UTErrorType)abortTest;

@end
