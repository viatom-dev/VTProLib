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
@property (nonatomic, assign) double tempValue;

/// @brief measure mode  ---  0 mainly forehead temperature or body temperature    1 other temperature
@property (nonatomic, assign) u_char measureMode;

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


NS_ASSUME_NONNULL_END
