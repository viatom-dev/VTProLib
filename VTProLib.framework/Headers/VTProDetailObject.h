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

@interface VTProEcgDetail : VTProDetailObject

@property (nonatomic, strong) NSMutableArray *arrEcgContent;

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

@property (nonatomic, assign) u_int timeLength;

@property (nonatomic, assign) FilterKind_t enFilterKind;

@property (nonatomic, assign) LeadKind_t enLeadKind;

/// @brief QT
@property (nonatomic, assign) u_short qtValue;

@property (nonatomic, assign) BOOL isQT;


@end

@interface VTProSlmDetail : VTProDetailObject

@property (nonatomic, strong) NSMutableArray *arrOxValue;

@property (nonatomic, strong) NSMutableArray *arrPrValue;

@end


NS_ASSUME_NONNULL_END
