//
//  VTMenuViewController.m
//  LibUseDemo
//
//  Created by 杨伟超 on 2020/6/14.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import "VTMenuViewController.h"
#import <VTProLib/VTProLib.h>
#import "VTInfoViewController.h"
#import "VTUserListViewController.h"
#import "VTDataListViewController.h"

@interface VTMenuViewController ()<UITableViewDelegate,UITableViewDataSource,VTProCommunicateDelegate>

@property (weak, nonatomic) IBOutlet UILabel *miniDescLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *funcArray;

@property (nonatomic, assign) VTProState state;

@property (nonatomic, assign) NSInteger event;

@end

@implementation VTMenuViewController
{
    VTProInfo *_info;
    NSArray <VTProUser *>*_userList;
    NSArray <VTProXuser *>*_xuserList;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [VTProCommunicate sharedInstance].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _state = VTProStateSyncData;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // dataType from 3 to 11
    _funcArray = @[@"Get info",@"Sync time",@"Read UserList",@"Daily Check",@"ECG Recorder",@"Pulse Oximeter",@"Blood Pressure",@"Blood Glucose",@"Thermometer",@"Sleep Monitor",@"Pedometer", @"Read XuserList", @"Quick check"];
    [VTProCommunicate sharedInstance].delegate = self;
    [[VTProCommunicate sharedInstance] beginPing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



- (IBAction)getInfo:(id)sender {
    if (_state == VTProStateMinimoniter) {
        return;
    }
    [[VTProCommunicate sharedInstance] beginGetInfo];
}

- (IBAction)syncTime:(id)sender {
    if (_state == VTProStateMinimoniter) {
        return;
    }
    [[VTProCommunicate sharedInstance] beginSyncTime:[NSDate date]];
}


- (IBAction)readUserList:(id)sender {
    if (_state == VTProStateMinimoniter) {
        return;
    }
    [[VTProCommunicate sharedInstance] beginReadFileListWithUser:nil fileType:VTProFileTypeUserList];
}

- (void)readXuserList{
    if (_state == VTProStateMinimoniter) {
        return;
    }
    [[VTProCommunicate sharedInstance] beginReadFileListWithUser:nil fileType:VTProFileTypeXuserList];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"gotoVTInfoViewController"]) {
        VTInfoViewController *vc = segue.destinationViewController;
        vc.proInfo = _info;
    }else if ([segue.identifier isEqualToString:@"gotoVTUserListViewController"]) {
        VTUserListViewController *vc = segue.destinationViewController;
        if (_event == 2) {
            vc.userArray = _userList;
        }else{
            vc.userArray = _xuserList;
        }
    }else if ([segue.identifier isEqualToString:@"gotoVTDataListViewController"]) {
        VTDataListViewController *vc = segue.destinationViewController;
        vc.dataType = _event;
        vc.userList = _userList;
        if (_event == 12) {
            vc.userList = _xuserList;
        }
        vc.title = _funcArray[_event];
    }
}

#pragma mark -- tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _funcArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"funcCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _funcArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _event = indexPath.section;
    switch (indexPath.section) {
        case 0:
            [self getInfo:nil];
            break;
        case 1:
            [self syncTime:nil];
            break;
        case 2:
            [self readUserList:nil];
            break;
        case 3:
        case 6:
        case 7:
        case 10:
        {
            if (_userList) {
                [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
            }else{
                [self readUserList:nil];
            }
        }
            break;
        case 4:
        case 5:
        case 8:
        case 9:
        {
            _userList = nil;
            _xuserList = nil;
            [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
        }
            break;
        case 11:
            [self readXuserList];
            break;
        case 12:
        {
            if (_xuserList) {
                [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
            }else{
                [self readXuserList];
            }
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark  --  delegate

- (void)getInfoWithResultData:(NSData *)infoData{
    if (infoData) {
        VTProInfo *info = [VTProFileParser parseProInfoWithData:infoData];
        _info = info;
        [self performSegueWithIdentifier:@"gotoVTInfoViewController" sender:nil];
    }else{
    
    }
}


- (void)commonResponse:(VTProCmdType)cmdType andResult:(VTProCommonResult)result{
    if (cmdType == VTProCmdTypeSyncTime) {
        if (result == VTProCommonResultSuccess) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sync time success"
                                                                           message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            DLog(@"success");
        }else{
            DLog(@"error");
        }
    }
}


- (void)readCompleteWithData:(VTProFileToRead *)fileData{
    if (fileData.fileType == VTProFileTypeUserList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *userList = [VTProFileParser parseUserList_WithFileData:fileData.fileData];
            _userList = userList;
            if (_event == 2) {
                [self performSegueWithIdentifier:@"gotoVTUserListViewController" sender:nil];
            }else{
                [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
            }
        }
    }
    
    if (fileData.fileType == VTProFileTypeXuserList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *userList = [VTProFileParser parseXuserList_WithFileData:fileData.fileData];
            _xuserList = userList;
            if (_event == 11) {
                [self performSegueWithIdentifier:@"gotoVTUserListViewController" sender:nil];
            }else{
                [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
            }
        }
    }
}


- (void)realTimeCallBackWithObject:(VTProMiniObject *)object{
    if (_state == VTProStateMinimoniter) {
        _miniDescLab.text = [object description];
    }
}


- (void)currentStateOfPeripheral:(VTProState)state{
    if (state == VTProStateMinimoniter) {
//        DLog(@"Minimonitor mode. If you want to import data which at peripheral into your phone, please exit minimonitor mode, and click 'To mobile' button.");
         [_miniDescLab setHidden:NO];
         [_tableView setHidden:YES];
    }else{
//        DLog(@"you can import data which at peripheral into your phone.");
        
        _funcArray = @[@"Get info",@"Sync time",@"Read UserList",@"Daily Check",@"ECG Recorder",@"Pulse Oximeter",@"Blood Pressure",@"Blood Glucose",@"Thermometer",@"Sleep Monitor",@"Pedometer", @"Read XuserList", @"Quick check"];
        [_miniDescLab setHidden:YES];
        [_tableView setHidden:NO];
    }
    _state = state;
}

@end

