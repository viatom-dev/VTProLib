//
//  VTProMiniObject.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/15.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTProMiniObject : NSObject

@property (nonatomic, strong) NSMutableArray *ecgArray;

@property (nonatomic, strong) NSMutableArray *spo2Array;

@property (nonatomic, assign) u_char spo2Value;

@property (nonatomic, assign) u_char spo2PIValue;

@property (nonatomic, assign) u_short spo2PRValue;

@property (nonatomic, assign) u_short hrValue;

@property (nonatomic, assign) u_short qrsValue;

@property (nonatomic, assign) u_short stValue;

@property (nonatomic, assign) u_short pvcValue;

@property (nonatomic, assign) u_char battery;

@property (nonatomic, assign) u_char spo2Identifier;

@property (nonatomic, assign) u_char hrIdentifier;

@property (nonatomic, assign) u_char pkgNum;


@end

NS_ASSUME_NONNULL_END
