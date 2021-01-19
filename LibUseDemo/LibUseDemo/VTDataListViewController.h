//
//  VTDataListViewController.h
//  LibUseDemo
//
//  Created by viatom on 2020/6/18.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VTProLib/VTProLib.h>


NS_ASSUME_NONNULL_BEGIN

@interface VTDataListViewController : UIViewController

@property (nonatomic, copy) NSArray *userList;

@property (nonatomic, assign) NSInteger dataType;

@end

NS_ASSUME_NONNULL_END
