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
    VTGender_FeMale,
    VTGender_Male
}VTGender_t;

NS_ASSUME_NONNULL_BEGIN

@interface VTProUser : NSObject


/// @brief user's name'
@property (nonatomic, strong) NSString *userName;

/// @brief userID - Used to read files
@property (nonatomic, assign) u_char userID;

/// @brief gender - 0: female  1: male
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




NS_ASSUME_NONNULL_END
