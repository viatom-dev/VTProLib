//
//  VTProFileParser.h
//  BTHealth
//
//  Created by demo on 13-11-4.
//  Update by Chao on  18-11-9
//  Copyright (c) 2013年 LongVision's Mac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTProUser.h"
#import "VTProInfo.h"
#import "VTProObject.h"
#import "VTProDetailObject.h"
#import "VTProMiniObject.h"
#import "VTTypesDef.h"

@interface VTProFileParser : NSObject

/**
 *  @brief parse all user through the data that get from peripheral
 *
 *  @param data the data that get from peripheral
 *
 *  @return return array contains items which is subclass of 'VTProUser'
 */
+ (NSArray <VTProUser *>*)parseUserList_WithFileData:(NSData *)data;

/**
 *  @brief parse CheckmePro infomation
 *
 *  @param data the data that get from peripheral
 *
 *  @return return item which is subclass of 'VTProInfo'
 */
+ (VTProInfo *)parseProInfoWithData:(NSData *)data;



/**
 *  @brief parse the Dlc(Daily Check) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProDlc'
 */
+ (NSArray <VTProDlc *>*)parseDlcList_WithFileData:(NSData *)data;


/**
 *  @brief parse the ECG(ECG Recorder) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProEcg'
 */
+ (NSArray <VTProEcg *>*)parseEcgList_WithFileData:(NSData *)data;


/**
 *  @brief parse the Spo2(Pulse Oximeter) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProSpO2'
 */
+ (NSArray <VTProSpO2 *>*)parseSPO2List_WithFileData:(NSData *)data;

/**
 *  @brief parse the bp(Blood Pressure) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProBp'
*/
+ (NSArray <VTProBp *>*)parseNIBPList_WithFileData:(NSData *)data;

/**
 *  @brief parse the Slm(Sleep Monitor) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProSlm'
 */
+ (NSArray <VTProSlm *>*)parseSLMList_WithFileData:(NSData *)data;

/**
 *  @brief parse the bg(Blood Glucose) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProBg'
*/
+ (NSArray <VTProBg *>*)parseBloodSugerList_WithFileData:(NSData *)data;

/**
 *  @brief parse the Tm(Thermometer) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProTm'
 */
+ (NSArray <VTProTm *>*)parseTempList_WithFileData:(NSData *)data;


/**
 *  @brief parse the Ped(Pedometer) list through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return array contains items which is subclass of 'VTProPed'
 */
+ (NSArray <VTProPed *>*)parsePedList_WithFileData:(NSData *)data;


/**
 *  @brief parse the instance of 'VTProEcgDetail' through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return the instance of 'VTProEcgDetail'
 */
+ (VTProEcgDetail *)parseEcg_WithFileData:(NSData *)data;


/**
 *  @brief parse the instance of 'VTProSlmDetail' through the data reading from blueTooth
 *
 *  @param data the data reading from blueTooth
 *
 *  @return return the instance of 'VTProSlmDetail'
 */
+ (VTProSlmDetail *)parseSLMData_WithFileData:(NSData *)data;

/**
 *  @brief parse the instance of 'VTProMiniObject' through the data reading from blueTooth
 *
 *  @param buff the buff notify from blueTooth
 *
 *  @param type the data  type
 *
 *  @return return the instance of 'VTProSlmDetail'
*/
+ (VTProMiniObject *)parseMiniDataWithBuff:(NSData *)buff andType:(u_char)type;

/**
 *  @brief parse the ecgResult strings with 'ecgResultDescrib'
 *
 *  @param ecgResultDescrib   the property of  'DailyCheckItem' or 'ECGInfoItem'
 *
 *  @return ecgResult strings
 */
+ (NSString *)parseECG_innerData_ecgResultDescribWith:(NSString *)ecgResultDescrib;


@end

@interface VTProFileParser (HouseKeeper)

/// @brief 支持checkmePro 同心管家
+ (NSArray <VTProXuser *>*)parseXuserList_WithFileData:(NSData *)data;
+ (NSArray <VTProSpc *>*)parseRecList_WithFileData:(NSData *)data;

@end

@interface VTProFileParser (PulsebitEX)

+ (NSArray <VTProEXHistory *>*)parseHeartCheckList:(NSData *)data;

+ (void)parseECGDetailWithFileData:(NSData *)data callBack:(EXECGDetailContent)content;


@end
