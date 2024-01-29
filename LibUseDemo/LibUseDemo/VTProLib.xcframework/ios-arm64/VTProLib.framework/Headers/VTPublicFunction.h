//
//  VTPublicFunction.h
//  libCheckme
//
//  Created by 李乾 on 15/4/27.
//  Copyright (c) 2015年 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTypesDef.h"

#pragma mark --- private enum ----
typedef enum : NSUInteger {
    VTProPkgLengthSend = 8,
    VTProPkgLengthReceive = 12,
    VTProPkgLengthContent = 512,
    VTProPkgLengthInfo = 8 + 256,
} VTProPkgLength;


typedef enum : u_char {
    VTProAckStatusOK = 0x00,
    VTProAckStatusErr = 0x01,
} VTProAckStatus;

typedef enum : NSUInteger {
    VTProTimeOutMSPing = 500,
    VTProTimeOutMSGeneral = 5000,
    VTProTimeOutMSUpdate = 80000,
} VTProTimeOutMS;    /// @brief command request timeout
// --- Write temporarily in this class ----

@interface VTPublicFunction : NSObject

+ (NSString*)makeDateFileName:(NSDateComponents*)date fileType:(VTProFileType)type;


+ (uint8_t)callCRC8:(unsigned char *)RP_ByteData bufSize:(unsigned int) Buffer_Size;



@end
