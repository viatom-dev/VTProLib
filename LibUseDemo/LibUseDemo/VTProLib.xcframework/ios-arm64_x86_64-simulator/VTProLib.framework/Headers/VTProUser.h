//
//  VTProUser.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/11.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    VTGender_Male,
    VTGender_FeMale
    
}VTGender_t;

NS_ASSUME_NONNULL_BEGIN

@interface VTProUser : NSObject


/// @brief user's name'
@property (nonatomic, copy) NSString *userName;

/// @brief userID - Used to read files
@property (nonatomic, assign) u_char userID;

/// @brief gender - 1: female  0: male
@property (nonatomic, assign) VTGender_t gender;

/// @brief user's height
@property (nonatomic, assign) double height;

/// @brief user's weight
@property (nonatomic, assign) double weight;

/// @brief user's age
@property (nonatomic, assign) int age;

/// @brief user's birthday
@property (nonatomic, strong) NSDateComponents *birthday;

/// @brief iconID - you can get or set icon for the user with this iconID
@property (nonatomic, assign) u_char iconID;


@end

/// @brief 支持checkmePro 同心管家
@interface VTProXuser : VTProUser

/**
 iconID && age 不支持
 */

@property (nonatomic, copy) NSString *patientID;

@property (nonatomic, assign) int unit;

@end




NS_ASSUME_NONNULL_END
