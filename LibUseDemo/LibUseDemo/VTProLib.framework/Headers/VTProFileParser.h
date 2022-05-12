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

+(void)parseECGDetailWithFileData:(NSData *)data callBack:(EXECGDetailContent)content;


@end

#pragma pack (1)
typedef struct PodDeviceRunParameters
{
    u_short PR;                 //当前主机实时脉率
    u_short oxi;
    u_char PI;
    u_short temp;               //当前主机实时温度
    u_char sys_flag;            // 0-1 血氧抬头状态（0 未插入电缆 1 插入电缆未插入手指 2 已插入手指）  2 体温探头是否插入（0 未插入 1插入） 3 是否有保存文件的动作（0 没有 1有）
    u_char bat_stat;            //电池状态 0:正常使用 1:充电中 2:充满 3:低电量
    u_char percent;             //电池电量 e.g.    100:100%
    u_char run_status;          //运行状态 0空闲，1测量准备（不画波形）2测量中
    u_char reserved[9];         //预留
}PodDeviceRunParameters;

typedef struct PodRealTimeWaveform{
    u_short sampling_num;        //采样点数
    short wave_data[300];        //原始数据
}PodRealTimeWaveform;

typedef struct PodRealTimeData
{
    PodDeviceRunParameters run_para;
    PodRealTimeWaveform waveform;
}PodRealTimeData;

typedef struct
{
    u_char spo2ProbeStatus;
    u_char tempProbeStatus;
    u_char reserved;
}sys_flagBit;

typedef struct
{
    u_short year;
    u_char month;
    u_char day;
    u_char hour;
    u_char minute;
    u_char second;
    u_char lead;
    u_char spO2;
    u_char pr;
    u_char pi;
    u_short temperature;
    u_char reserved[4];
}PodHistoryData;

#pragma pack ()

@interface VTProFileParser (CheckmePod)


+ (PodRealTimeData)parsePodRealDataWithResponse:(NSData * _Nonnull)response;

+ (void)parsePodHistoryListWithResponse:(NSData * _Nonnull)response callback:(void(^_Nullable)(PodHistoryData * _Nullable list, NSInteger count))callback;

@end
