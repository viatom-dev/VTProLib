//
//  VTPublicUtils.h
//  libCheckme
//
//  Created by 李乾 on 15/4/27.
//  Copyright (c) 2015年 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTypesDef.h"

@interface VTPublicUtils : NSObject

+ (NSString*)makeDateFileName:(NSDateComponents*)date fileType:(VTProFileType)type;


+ (uint8_t)calCRC8:(unsigned char *)RP_ByteData bufSize:(unsigned int) Buffer_Size;

/**
 *  parse the ecgResult strings with 'ecgResultDescrib'
 *
 *  @param ecgResultDescrib   the property of  'DailyCheckItem' or 'ECGInfoItem'
 *
 *  @return ecgResult strings
 */
+ (NSString *) parseECG_innerData_ecgResultDescribWith:(NSString *)ecgResultDescrib;

@end
