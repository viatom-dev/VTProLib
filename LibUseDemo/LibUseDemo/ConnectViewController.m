//
//  ConnectViewController.m
//  NoiseDemo
//
//  Created by Viatom on 2018/10/25.
//  Copyright © 2018年 Viatom. All rights reserved.
//

#import "ConnectViewController.h"
#import "BTUtils.h"

@interface ConnectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *periArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    [[BTUtils GetInstance] openBT];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findPeriphral:) name:FINDPERIPHRAL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBLPowerOnNtf:) name:BLE_ON object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBLPowerOffNtf:) name:BLE_OFF object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectState:) name:CONNECTED object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)prefersStatusBarHidden{
    return NO;
}



-(void)onBLPowerOnNtf:(NSNotification *)ntf
{
    [[BTUtils GetInstance] beginScan];
}

//
-(void)onBLPowerOffNtf:(NSNotification *)ntf
{
    
}


-(void)connectState:(NSNotification *)notification
{
    if ([notification.object intValue] == 1) {
        [self showAlertWithTitle:@"Connected" message:@"" handler:^(UIAlertAction *action) {
            [self performSegueWithIdentifier:@"presentViewController" sender:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"connectSuccess" object:nil];
            
        }];
    }
}

-(void)findPeriphral:(NSNotification *)ntf
{
    NSDictionary *usrInfo  = [ntf userInfo];
    CBPeripheral *periphral = [usrInfo objectForKey:KEYPERIPHRAL];
    NSString *BLEname =  usrInfo[@"BLEName"];
    if(![BLEname isKindOfClass:[NSNull class]]&& ![BLEname isEqualToString:@""] && ![periphral.name isEqualToString:BLEname])
    {
        [periphral setValue:BLEname forKey:@"name"];
    }
  
    if ([[periphral name] hasPrefix:@"Checkme"]) {//设备蓝牙名
        NSMutableArray *tempArr = [self.periArray mutableCopy];
        for (CBPeripheral *lp in tempArr) {
            if ([lp.name isEqualToString:periphral.name]) {
                [self.periArray removeObject:lp];
            }
            
        }
        [self.periArray addObject:periphral];
        [self.tableView reloadData];
    }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.periArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    CBPeripheral *p = self.periArray[indexPath.row];
    cell.textLabel.text = [p name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *p = self.periArray[indexPath.row];
    [[BTUtils GetInstance] connectToPeripheral:p];
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
