//
//  VTInfoViewController.m
//  LibUseDemo
//
//  Created by 杨伟超 on 2020/6/14.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import "VTInfoViewController.h"
#import <objc/runtime.h>

@interface VTInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation VTInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_proInfo == nil) {
        _infoLabel.text = @"Get device information error";
        return;
    }
    _infoLabel.text = [_proInfo description];
}

- (void)setProInfo:(VTProInfo *)proInfo{
    _proInfo = proInfo;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
