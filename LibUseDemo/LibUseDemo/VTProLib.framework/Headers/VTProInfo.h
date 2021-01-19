//
//  VTProInfo.h
//  Checkme Mobile
//
//  Created by Joe on 14/11/11.
//  Copyright (c) 2014年 VIATOM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VTProInfo : NSObject


/// @brief peripheral's region
@property (nonatomic, copy) NSString *region;

/// @brief peripheral's model
@property (nonatomic, copy) NSString *model;

/// @brief peripheral's hardware version
@property (nonatomic, copy) NSString *hardware;

/// @brief peripheral's software version
@property (nonatomic, copy) NSString *software;

/// @brief peripheral's language
@property (nonatomic, copy) NSString *language;

/// @brief peripheral's theCurLanguage
@property (nonatomic, copy) NSString *theCurLanguage;

/// @brief peripheral's sn number
@property (nonatomic, copy) NSString *sn;

/// @brief peripheral's application
@property (nonatomic, copy) NSString *application;

/// @brief peripheral's spcPVer
@property (nonatomic, copy) NSString *spcPVer;

/// @brief peripheral's file version
@property (nonatomic, copy) NSString *fileVer;


@property (nonatomic, copy) NSString *branchCode;

@end
