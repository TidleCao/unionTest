//
//  UTTestEngine.m
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import "UTTestEngine.h"
#import "UTTestItem.h"

@interface UTTestEngine () <UTTestItemDelegate>
{
    UTTestItem *_currentTestItem;
}

@property UTTestState state;

@end

@implementation UTTestEngine



- (UTErrorType)startTest {
    
    // 防止重复启动。
    if (_state == UTTestStateTesting) {
        return UTErrorTypeNoError;
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(shouldStartTestEngine:)]) {

        BOOL shouldStart = [_delegate shouldStartTestEngine:self];
        // 测试引擎被禁止。
        if (shouldStart == NO) {
            return UTErrorTypeDisabled ;
        }
        
    }else {
        return UTErrorTypeDisabled ;
    }
    
    [self setState:UTTestStateTesting];
    
    // 通知代理测试开始
    if ([_delegate respondsToSelector:@selector(willStartTestEngine:)]) {
        [_delegate willStartTestEngine:self];
    }

    
    for (UTTestItem *testItem in _testItems) {
        
        // 如果用户点击暂停、放弃测试
        if (_state == UTTestStatePausing || _state == UTTestStateAborting ) {
            break;
        }
        
        _currentTestItem = testItem;
        // 判断是否需要测试该项目
        if (testItem.state == UTTestStateIDLE && [_delegate testEngine:self shouldStartTestItem:testItem]) {
            
            // 通知代理开始测试
            if ([_delegate respondsToSelector:@selector(testEngine:willStartTestItem:)]) {
                [_delegate testEngine:self willStartTestItem:testItem];
            }
            
            [_currentTestItem runTest];
            
            if ([_delegate respondsToSelector:@selector(testEngine:didFinishTestItem:)]) {
                [_delegate testEngine:self didFinishTestItem:testItem];
            }
        }
    }
    
    // 设置状态
    
    if (_state == UTTestStateTesting) {
        
        [self setState:UTTestStateFinished];
        
    }
    
    _currentTestItem = nil;

    return UTErrorTypeNoError;
}

- (UTErrorType)stopTest {
    
    if (_currentTestItem != nil) {
        [self setState:UTTestStatePausing];
        [_currentTestItem stopTest];
    }
    
    return UTErrorTypeNoError;
}

- (UTErrorType)abortTest {
    
    if (_currentTestItem != nil) {
        [self setState:UTTestStateAborting];
        [_currentTestItem abortTest];
    }
    
    return UTErrorTypeNoError;
}

// MARK: - UTTestItemDelegate

- (BOOL)testItem:(UTTestItem *)testItem shouldStartTestAction:(UTTestAction *)testAction {
    return YES;
}

- (void)testItem:(UTTestItem *)testItem willStartTestAciotn:(UTTestAction *)testAction {
    
}

- (void)testItem:(UTTestItem *)testItem didFinishTestAction:(UTTestAction *)testAction {
    
}

- (void)testItemDidFinishTesting:(UTTestItem*)testItem {
    
}

- (void)testItemDidAbortTesting:(UTTestItem*)testItem {
    
    if (_state == UTTestStateAborting) {
        
        [self setState:UTTestStateAborted];
        
    }

}

- (void)testItemDidStopTesting:(UTTestItem*)testItem {
    
    if (_state == UTTestStatePausing) {
        [self setState:UTTestStatePaused];
    }
}
@end
