//
//  ConnectViewController.m
//  NoiseDemo
//
//  Created by Viatom on 2018/10/25.
//  Copyright © 2018年 Viatom. All rights reserved.
//

#import "ConnectViewController.h"
#import "VTBLEUtils.h"
#import <VTProLib/VTProCommunicate.h>

@interface ConnectViewController ()<UITableViewDelegate,UITableViewDataSource, VTBLEUtilsDelegate, VTProCommunicateDelegate>

@property (nonatomic, strong) NSMutableArray *periArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    [VTBLEUtils sharedInstance].delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)prefersStatusBarHidden{
    return NO;
}


#pragma mark --  ble

- (void)updateBleState:(VTBLEState)state{
    if (state == VTBLEStatePoweredOn) {
        [[VTBLEUtils sharedInstance] startScan];
    }
}

- (void)didDiscoverDevice:(VTDevice *)device{
    [self.periArray addObject:device];
    [self.tableView reloadData];
}

- (void)didConnectedDevice:(VTDevice *)device{
    [VTProCommunicate sharedInstance].peripheral = device.rawPeripheral;
    [VTProCommunicate sharedInstance].delegate = self;
}

/// @brief This device has been disconnected. Note: If error == nil ，user manually disconnect.
- (void)didDisconnectedDevice:(VTDevice *)device andError:(NSError *)error{
    
}


- (void)serviceDeployed:(BOOL)completed{
    [self showAlertWithTitle:@"Good !!!" message:@"Start work" handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"presentViewController" sender:nil];
    }];
}




- (NSMutableArray *)periArray{
    if (!_periArray) {
        _periArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _periArray;
}


- (UIView *)headerView{
    if (!_headerView) {
        CGFloat safeH = 20;
        if (CGRectGetHeight(self.view.frame) > 736 && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            safeH = 44;
        }
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 44 + safeH)];
        [self.view addSubview:_headerView];
        [_headerView setBackgroundColor:[UIColor colorWithRed:38.0/255 green:154.0/255 blue:208.0/255 alpha:1.0]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, safeH, CGRectGetMaxX(self.view.frame)*0.4, 44)];
        [titleLabel setText:@"Scanner"];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:40]];
        [titleLabel setAdjustsFontSizeToFitWidth:YES];
        [_headerView addSubview:titleLabel];
    }
    return _headerView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.headerView.frame)) style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark --  tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.periArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"deviceList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    VTDevice *device = self.periArray[indexPath.row];
    cell.textLabel.text = device.rawPeripheral.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",device.RSSI];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VTDevice *device = self.periArray[indexPath.row];
    [[VTBLEUtils sharedInstance] stopScan];
    [[VTBLEUtils sharedInstance] connectToDevice:device];
}




- (void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
                   handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler];
    [alertVC addAction:confirAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
