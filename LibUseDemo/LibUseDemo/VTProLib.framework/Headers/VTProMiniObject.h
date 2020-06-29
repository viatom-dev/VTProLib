//
//  VTProMiniObject.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/15.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// @brief Minimonitor  Packet data   --  1 pcs  /40ms.    A part of data not support at current version. 
@interface VTProMiniObject : NSObject

/// @brief ECG data with real-time data
@property (nonatomic, strong) NSMutableArray *ecgArray;

/// @brief SpO2 data with real-time data
@property (nonatomic, strong) NSMutableArray *spo2Array;

/// @brief SpO2 Value
@property (nonatomic, assign) u_char spo2Value;

/// @brief SpO2 - PI Value
@property (nonatomic, assign) u_char spo2PIValue;

/// @brief SpO2 - PR Value
@property (nonatomic, assign) u_short spo2PRValue;

/// @brief ECG - HR Value
@property (nonatomic, assign) u_short hrValue;

/// @brief ECG - QRS Value
@property (nonatomic, assign) u_short qrsValue;

/// @brief ECG - ST Value
@property (nonatomic, assign) u_short stValue;

/// @brief ECG - PVCs Value
@property (nonatomic, assign) u_short pvcValue;

/// @brief battery of peripheral
@property (nonatomic, assign) u_char battery;

/// @brief SpO2 - PR marker
@property (nonatomic, assign) u_char spo2Identifier;

/// @brief ECG - R wave marker
@property (nonatomic, assign) u_char ecgRIdentifier;

/// @brief Packet number .  A part of version is not support.
@property (nonatomic, assign) u_char pkgNum;


@end

NS_ASSUME_NONNULL_END
