//
//  UTTestItem.m
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import "UTTestItem.h"
#import "UTTestAction.h"

@interface UTTestItem ()
{
    UTTestAction *_currentTestAction;
    NSArray *_pendingTestActions;
    
}

@property (nonatomic) UTTestState state;

@end

@implementation UTTestItem

- (void)setState:(UTTestState)state {
    _state = state;
    
    // 通知代理状态发生改变
    if (_state == UTTestStateFinished) {
        if ([_delegate respondsToSelector:@selector(testItemDidFinishTesting:)]) {
            [_delegate testItemDidFinishTesting:self];
        }
    }else if (_state == UTTestStateAborted) {
        if ([_delegate respondsToSelector:@selector(testItemDidAbortTesting:)]) {
            [_delegate testItemDidAbortTesting:self];
        }
    }else if (_state == UTTestStatePaused) {
        if ([_delegate respondsToSelector:@selector(testItemDidStopTesting:)]) {
            [_delegate testItemDidStopTesting:self];
        }
    }
}

- (void)_executeTestAction: (NSArray *)actions {
    
    NSUInteger idx = 0;
    for(UTTestAction *action in actions) {
        _currentTestAction = action;
        idx += 1;
        if (_state != UTTestStateTesting ) {
            // 保存当前的测试状态，以便下次恢复。
            if (_state == UTTestStatePausing && idx < actions.count) {
                _pendingTestActions = [actions subarrayWithRange:NSMakeRange(idx, actions.count - idx)];
            }
            break;
        }
       
        BOOL shouldStart = [_delegate testItem:self shouldStartTestAction:action];
        
        if (shouldStart) {
            
            if ([_delegate respondsToSelector:@selector(testItem:willStartTestAciotn:)]) {
                [_delegate testItem:self willStartTestAciotn:action];
            }
            //TODO: 暂时不考虑action并行执行的问题
            
            [action execute];
            
            if ([_delegate respondsToSelector:@selector(testItem:didFinishTestAction:)]) {
                [_delegate testItem:self didFinishTestAction:action];
            }
        }
        
    }
    
    // 设置状态
    if (_state == UTTestStatePausing) {
        [self setState:UTTestStatePaused];
        
    }else if (_state == UTTestStateAborting) {
        [self setState:UTTestStateAborted];
        
    }else {
        [self setState:UTTestStateFinished];
    }
 
}

- (UTErrorType)runTest {
    
    // 防止重复启动。
    if (_state == UTTestStateTesting) {
        return UTErrorTypeNoError;
    }
    
    // 必须设置代理
    if (_delegate == nil) return UTErrorTypeNoError;
   
    if (_currentTestAction != nil && _pendingTestActions.count > 0) {
       // 暂停恢复测试的流程
        [self _executeTestAction:_pendingTestActions];
        
    }else {
        // 新测试的流程
        [self _executeTestAction:_actions];
    }

    
    _currentTestAction = nil;
    
    return UTErrorTypeNoError;
    
}

// 暂停停止
- (void)stopTest {
    [self setState:UTTestStatePausing];
}

// 放弃测试
- (void)abortTest {
    [self setState:UTTestStateAborting];
}

// 恢复暂停的测试
- (void)resumeTest {
    
    if (_state == UTTestStatePaused && _pendingTestActions.count > 0) {
        [self setState:UTTestStateTesting];
        [self runTest];
        _pendingTestActions = nil;
    }

}


@end
