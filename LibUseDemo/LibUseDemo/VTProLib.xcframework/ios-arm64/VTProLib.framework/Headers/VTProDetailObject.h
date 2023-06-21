//
//  VTProDetailObject.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/12.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTypesDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface VTProDetailObject : NSObject

@end

/// @brief Daily Check or ECG Recorder detail data.
@interface VTProEcgDetail : VTProDetailObject

/// @brief The mv value of all sampling points can be used to draw ECG waveform.    Sampling Rate ： 500
@property (nonatomic, strong) NSMutableArray *arrEcgContent;

/// @brief Heart rate value during ECG measurement.   2 times/s
@property (nonatomic, strong) NSMutableArray *arrEcgHeartRate;

/// @brief Heart rate
@property (nonatomic, assign) u_short hrValue;

/// @brief ST
@property (nonatomic, assign) short stValue;

/// @brief QRS
@property (nonatomic, assign) u_short qrsValue;

/// @brief PVCs
@property (nonatomic, assign) u_short pvcsValue;

/// @brief QTc
@property (nonatomic, assign) u_short qtcValue;

/// @brief result for ecg
@property (nonatomic, copy) NSString *ecgResult;

/// @brief duration 
@property (nonatomic, assign) u_int timeLength;

@property (nonatomic, assign) FilterKind_t enFilterKind;

@property (nonatomic, assign) LeadKind_t enLeadKind;

/// @brief QT
@property (nonatomic, assign) u_short qtValue;

/// @brief Whether to include QT
@property (nonatomic, assign) BOOL isQT;


@end

/// @brief Sleep Monitor detail data
@interface VTProSlmDetail : VTProDetailObject

/// @brief Blood oxygen collected during sleep.
@property (nonatomic, strong) NSMutableArray *arrOxValue;

/// @brief Pulse rate collected during sleep.
@property (nonatomic, strong) NSMutableArray *arrPrValue;

@end

#pragma pack (1)
typedef struct{
    u_short hrLen;
    u_int dataLen;              //2-5    length of waveform
    u_short hrResult;           //6-7    heart rate， unit is bpm
    u_short stResult;           //8-9    ST, unit is mV
    u_short qrsResult;          //10-11    QRS, unit is mV
    u_short pvcsResult;         //12-13    PVCs
    u_short qtcResult;          //14-15    QTc, unit is ms
    u_int ecgAbnormalResult;    //16-19
    u_char measuringMode;       //20
    u_char filterMode;          //21   （1：wide   0：normal）
    u_short qtResult;           //22-23    QT, unit is ms
    u_char reserved[20];        //24-43  reserved
}EXEcgFileHeader;

#pragma pack ()

typedef void(^EXECGDetailContent)(EXEcgFileHeader header, NSMutableArray * _Nullable ecgContent);

@interface VTProEXHistoryDetail : VTProDetailObject


@end


NS_ASSUME_NONNULL_END
