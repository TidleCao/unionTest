//
//  UTErrors.h
//  UTTestKit
//
//  Created by jifu on 21/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

#ifndef UTErrors_h
#define UTErrors_h

typedef NS_ENUM(NSUInteger, UTErrorType) {
    UTErrorTypeNoError,         // 无错误发生。
    UTErrorTypeDisabled,        // 因被禁用引发的错误。
    UTErrorTypeUserStopped,     // 因用户停止操作引发的错误。
    UTErrorTypeUserAborted,     // 因用户放弃操作引发的错误。
    UTErrorTypeUnknow = -1,     // 其他错误。
};


#endif /* UTErrors_h */
