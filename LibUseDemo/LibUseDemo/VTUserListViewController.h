//
//  VTUserListViewController.h
//  LibUseDemo
//
//  Created by 杨伟超 on 2020/6/14.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VTProLib/VTProUser.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTUserListViewController : UIViewController

@property (nonatomic, strong) NSArray <VTProUser *>*userArray;

@end

NS_ASSUME_NONNULL_END
