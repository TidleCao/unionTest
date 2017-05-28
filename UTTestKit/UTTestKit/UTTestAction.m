//
//  UTTestAction.m
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#import "UTTestAction.h"

@implementation UTTestAction

- (void)execute {
    IMP imp = [_target methodForSelector:_action];
    id (*func)(id, SEL, id, id) = (void *) imp;
    _returnValue = func(_target, _action, _params, _context);
}

@end
