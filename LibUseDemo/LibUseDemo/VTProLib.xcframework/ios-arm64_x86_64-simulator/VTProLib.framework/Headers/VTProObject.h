//
//  VTProObject.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/11.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTypesDef.h"

NS_ASSUME_NONNULL_BEGIN

/// @brief all vt pro object read from list by list-type
@interface VTProObject : NSObject

/// @brief the data's userID
@property (nonatomic, assign) u_char userID;

/// @brief the data's measure date & time
@property (nonatomic, strong) NSDateComponents *dtcDate;

@end


/// @brief daily check data
@interface VTProDlc : VTProObject

/// @brief heart rate value
@property (nonatomic, assign) u_short hrValue;

/// @brief heart rate result  ---  the result map to emoji :    0 - smile    1 - cry     2 - null
@property (nonatomic, assign) PassKind_t hrResult;

/// @brief SpO2 value
@property (nonatomic, assign) u_char spo2Value;

/// @brief SpO2 result  ---  the result map to emoji :    0 - smile    1 - cry     2 - null
@property (nonatomic, assign) PassKind_t spo2Result;

/// @brief Perfusion Index
@property (nonatomic, assign) double pIndex;

/// @brief blood pressure flag --- blood pressure value is invalid when this flag is equal to 0xFF
@property (nonatomic, assign) u_char bpFlag;

/// @brief blood pressure value
@property (nonatomic, assign) u_char bpValue;

/// @brief Is there a voice to download.
@property (nonatomic, assign) BOOL haveVoice;

@end


/// @brief ecg recorder data
@interface VTProEcg : VTProObject

/// @brief lead kind .  view  'LeadKind_t'  enum
@property (nonatomic, assign) LeadKind_t enLeadKind;

@property (nonatomic, assign) PassKind_t enPassKind;

@property (nonatomic, assign) BOOL haveVoice;

@end


/// @brief pulse oximeter data
@interface VTProSpO2 : VTProObject

@property (nonatomic, assign) u_char spo2Value;

@property (nonatomic, assign) u_short prValue;

@property (nonatomic, assign) double pIndex;

@property (nonatomic, assign) PassKind_t enPassKind;

@end


/// @brief blood pressure data
@interface VTProBp : VTProObject

/// @brief Systolic blood pressure
@property (nonatomic, assign) u_short sysValue;

/// @brief Diastolic blood pressure
@property (nonatomic, assign) u_char diaValue;

/// @brief Pulse rate
@property (nonatomic, assign) u_char prValue;

@end



/// @brief blood glucose data
@interface VTProBg : VTProObject

/// @brief blood glucose value ---  low : [1.1,3.8]    normal : [3.9,7.2]   high : [7.3,33.3]  ;   other value  is error
@property (nonatomic, assign) double sugerValue;

/// @brief note map to peripheral's note
@property (nonatomic, copy) NSString *note;

@end


/// @brief thermometer
@interface VTProTm : VTProObject

/// @brief temperature   ---  celsius  It  map  to  fahrenheit  by formula ----  tempValue * 1.8 + 32
/// 温度 存储值为温度值*10，单位为℃，此处使用整数表示，如38.5℃则为385
@property (nonatomic, assign) double tempValue;

/// @brief measure mode  ---  0 mainly forehead temperature or body temperature    1 other temperature
///  测量方式  0:体温 1:物体温度
@property (nonatomic, assign) u_char measureMode;

/// @brief The result map to emoji :    0 - smile    1 - cry     2 - null
/// 体温笑脸/哭脸  0是笑脸，1是哭脸，其他值无效
@property (nonatomic, assign) PassKind_t enPassKind;

@end


/// @brief sleep monitor
@interface VTProSlm : VTProObject

/// @brief duration of sleep
@property (nonatomic, assign) u_int totalTime;

@property (nonatomic, assign) PassKind_t enPassKind;

/// @brief duration of hypoxemia
@property (nonatomic, assign) u_short lowOxTime;

/// @brief number of blood oxygen drops
@property (nonatomic, assign) u_short lowOxNumber;

/// @brief minimum blood oxygen
@property (nonatomic, assign) u_char lowestOx;

/// @brief average blood oxygen
@property (nonatomic, assign) u_char averageOx;

@end


/// @brief pedometer
@interface VTProPed : VTProObject

/// @brief step count
@property (nonatomic, assign) u_int steps;

/// @brief distance  km
@property (nonatomic, assign) double distance;

/// @brief speed   km/h
@property (nonatomic, assign) double speed;

/// @brief calorie  kcal
@property (nonatomic, assign) double calorie;

/// @brief fat   g
@property (nonatomic, assign) double fat;

/// @brief total time   s
@property (nonatomic, assign) u_int totalTime;

@end

@interface VTProEXHistory : VTProObject

//用户(1是A用户，2是B用户，别的值为无用户)
// User userID 1: user A  2: user B

/// @brief RecordTime .  yyyyMMddHHmmss
@property (nonatomic, copy) NSString *recordTime;

/// @brief Heart rate .
@property (nonatomic, assign) u_short heartRate;

/// @brief The result map to emoji :    0 - smile    1 - cry     2 - null
@property (nonatomic, assign) PassKind_t hrEmoji;

/// @brief SpO2
@property (nonatomic, assign) u_char spo2;

@property (nonatomic, assign) PassKind_t spo2Emoji;

/// @brief PI
@property (nonatomic, assign) u_char pi;

/// @brief Pulse rate
@property (nonatomic, assign) u_char pr;

//标志位/舒张压（若为0x00则表示第14字节是百分百，是0xFF，第14字节表示BP为无效值，否则表示舒张压第16字节为收缩压）
/// @brief Flag  (If it is 0x00, it means that the 14th byte is 100%, which is 0xFF, and the 14th byte means that BP is an invalid value, otherwise it means that the 16th byte of diastolic blood pressure is systolic blood pressure)
@property (nonatomic, assign) u_char bpFlag;

//yyyymmddhhmmss文件-ECG
/// @brief ECG Detail data.
@property (nonatomic, copy) NSData *ecgData;

@end


/// @brief 支持checkmePro 同心管家
@interface VTProSpc : VTProObject
/// @brief 通用
// 功能模式 0:单测模式  1:组合模式
@property (nonatomic, assign) u_char funcMode;
// 功能选择 Bit0:心电 Bit1:血氧 Bit2:体温 Bit3:血压 Bit4:血糖  Bit5-Bit15:预留
@property (nonatomic, assign) u_short selectFunc;
// 标注
@property (nonatomic, copy) NSString *note;
/// @brief 心电
// 测量方式 0:预留  1:手手 2:手膝 3:I导  4:II导
@property (nonatomic, assign) LeadKind_t enLeadKind;
// 脉率
@property (nonatomic, assign) u_short hrValue;
// qrs值
@property (nonatomic, assign) u_short qrsValue;
// st值
@property (nonatomic, assign) u_short stValue;
// 心电分析结果 parseECG_innerData_ecgResultDescribWith:
@property (nonatomic, assign) NSString *ecgResult;
// 笑脸/哭脸  0是笑脸，1是哭脸，其他值无效
@property (nonatomic, assign) PassKind_t ecgEmoj;
// QT值
@property (nonatomic, assign) u_short qtValue;
// QTc值
@property (nonatomic, assign) u_short qtcValue;
// 波形标记 0:无波形数据  1:有波形数据
@property (nonatomic, assign) u_char waveMark;
/// @brief 血氧
// 测量方式 0:内部  1:外部
@property (nonatomic, assign) u_char measureMode;
// 血氧
@property (nonatomic, assign) u_char spo2Value;
// 脉率
@property (nonatomic, assign) u_short prValue;
// 脉搏灌注强度
@property (nonatomic, assign) double piValue;
// 笑脸/哭脸  0是笑脸，1是哭脸，其他值无效
@property (nonatomic, assign) PassKind_t spo2Emoj;
// 体温
@property (nonatomic, strong) VTProTm *temp;
/// @brief 血压
// 测量仪器 0 AirBP 1 小企鹅
@property (nonatomic, assign) u_char measureFrom;
// 收缩压
@property (nonatomic, assign) u_short sysValue;
// 平均压
@property (nonatomic, assign) u_char avgValue;
// 舒张压
@property (nonatomic, assign) u_char diaValue;
// 是否心率不起 0 正常 1 心率不齐
@property (nonatomic, assign) u_char irregular;
// 脉率
@property (nonatomic, assign) u_short bpprValue;
/// @brief 血糖
// 测量来源
@property (nonatomic, assign) u_char bgFrom;
// 存储值为血糖值*10， 单位mmol/L
@property (nonatomic, assign) double sugerValue;


@end


NS_ASSUME_NONNULL_END
