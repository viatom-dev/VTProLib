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

// branchCode distinguish
#define KDomesticCodes @[@"10220002", @"10220003"]


// ----------------------------------------------------

@interface NameEventModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger event;

- (instancetype)initWithTitle:(NSString *)title event:(NSInteger)event;

@end

@implementation NameEventModel

- (instancetype)initWithTitle:(NSString *)title event:(NSInteger)event {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _title = title;
    _event = event;
    return self;
}

@end

// ----------------------------------------------------


@interface VTMenuViewController ()<UITableViewDelegate,UITableViewDataSource,VTProCommunicateDelegate>

@property (weak, nonatomic) IBOutlet UILabel *miniDescLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<NameEventModel *> *funcArray;

@property (nonatomic, assign) VTProState state;

@property (nonatomic, strong) NameEventModel *currNEModel;

@property (nonatomic, assign)BOOL isInitialRequest;

@property (nonatomic, assign) BOOL isDomesticCheckme;

@end

@implementation VTMenuViewController
{
    VTProInfo *_info;
    NSArray <VTProUser *>*_userList;
    NSArray <VTProXuser *>*_xuserList;
}

static NSString *  getInfo = @"Get info";
static NSString *  syncTime = @"Sync time";
static NSString * const readUserList = @"Read UserList";
static NSString * const readDlc = @"Daily Check";
static NSString *  readEcg = @"ECG Recorder";  // 心电
static NSString *  readOxi = @"Pulse Oximeter";    // 指脉
static NSString *  readBP = @"Blood Pressure"; // 血压
static NSString *  readBG = @"Blood Glucose";  // 血糖
static NSString *  readTM = @"Thermometer";    // 体温
static NSString * const readSlm = @"Sleep Monitor";
static NSString * const readPed = @"Pedometer";
static NSString *  readXuserList = @"Read XuserList";
static NSString *  readQC = @"Quick check";    // 一键体检
static NSString * const readHC = @"HeartCheck"; // --


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [VTProCommunicate sharedInstance].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _state = VTProStateSyncData;
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    if (![[VTProCommunicate sharedInstance].peripheral.name hasPrefix:@"Checkme"]) {
        [self initFuncArray];
    }
    // dataType from 3 to 11
    
    [VTProCommunicate sharedInstance].delegate = self;
    [[VTProCommunicate sharedInstance] beginPing];
    
    _isInitialRequest = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[VTProCommunicate sharedInstance] beginGetInfo];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)initFuncArray {
    if (_funcArray && _funcArray.count > 0) {
        return;
    }
    
    if ([[VTProCommunicate sharedInstance].peripheral.name hasPrefix:@"Checkme"] && _info && [KDomesticCodes containsObject:_info.branchCode]) {
        self.title = @"菜单";
        _isDomesticCheckme = YES;
        
        getInfo = @"获取设备信息";
        syncTime = @"同步时间";
        readEcg = @"心电";
        readOxi = @"指脉";
        readBP = @"血压";
        readBG = @"血糖";
        readTM = @"体温";
        readQC = @"一键体检";
        readXuserList = @"读取用户列表";
    }
    
    NameEventModel *getInfoModel = [[NameEventModel alloc] initWithTitle:getInfo event:0];
    NameEventModel *syncTimeModel = [[NameEventModel alloc] initWithTitle:syncTime event:1];
    NameEventModel *readUserListModel = [[NameEventModel alloc] initWithTitle:readUserList event:2];
    NameEventModel *readDlcModel = [[NameEventModel alloc] initWithTitle:readDlc event:3];
    NameEventModel *readEcgModel = [[NameEventModel alloc] initWithTitle:readEcg event:4];
    NameEventModel *readOxiModel = [[NameEventModel alloc] initWithTitle:readOxi event:5];
    NameEventModel *readBPModel = [[NameEventModel alloc] initWithTitle:readBP event:6];
    NameEventModel *readBGModel = [[NameEventModel alloc] initWithTitle:readBG event:7];
    NameEventModel *readTMModel = [[NameEventModel alloc] initWithTitle:readTM event:8];
    NameEventModel *readSlmModel = [[NameEventModel alloc] initWithTitle:readSlm event:9];
    NameEventModel *readPedModel = [[NameEventModel alloc] initWithTitle:readPed event:10];
    NameEventModel *readXuserListModel = [[NameEventModel alloc] initWithTitle:readXuserList event:11];
    NameEventModel *readQCModel = [[NameEventModel alloc] initWithTitle:readQC event:12];
    NameEventModel *readHCModel = [[NameEventModel alloc] initWithTitle:readHC event:13];
    
    
    if ([[VTProCommunicate sharedInstance].peripheral.name hasPrefix:@"Checkme"]) {
        if (_isDomesticCheckme) { // 国内版
            _funcArray = @[getInfoModel, syncTimeModel, readEcgModel, readOxiModel, readBPModel, readBGModel, readTMModel, readQCModel, readXuserListModel];
            return;
        }
        
        _funcArray = @[getInfoModel, syncTimeModel, readUserListModel, readDlcModel, readEcgModel, readOxiModel, readBPModel, readBGModel, readTMModel, readSlmModel, readPedModel];
    }else{
        _funcArray = @[getInfoModel, syncTimeModel, readHCModel];
    }
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
        vc.title = _isDomesticCheckme ? @"设备信息" : @"Device information";
    }else if ([segue.identifier isEqualToString:@"gotoVTUserListViewController"]) {
        VTUserListViewController *vc = segue.destinationViewController;
        if (_currNEModel.event == 2) {
            vc.userArray = _userList;
        }else{
            vc.userArray = _xuserList;
        }
        vc.title = _isDomesticCheckme ? @"用户列表" : @"User List";
    }else if ([segue.identifier isEqualToString:@"gotoVTDataListViewController"]) {
        VTDataListViewController *vc = segue.destinationViewController;
        vc.dataType = _currNEModel.event;
        vc.userList = _userList;
        if (_currNEModel.event == 12) {
            vc.userList = _xuserList;
        }
        vc.title = _currNEModel.title;
    }
}

#pragma mark -- tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.funcArray.count;
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
    cell.textLabel.text = _funcArray[indexPath.section].title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currNEModel = _funcArray[indexPath.section];
    NSLog(@"_event: %ld, section: %ld", (long)_currNEModel.event, (long)indexPath.section);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    if ([title isEqual:getInfo]) {
        [self getInfo:nil];
    }
    if ([title isEqual:syncTime]) {
        [self syncTime:nil];
    }
    if ([title isEqual:readUserList]) {
        [self readUserList:nil];
    }
    if ([title isEqual:readDlc] ||
        [title isEqual:readBP] ||
        [title isEqual:readBG] ||
        [title isEqual:readPed]) {
        if (_userList) {
            [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
        }else{
            [self readUserList:nil];
        }
    }
    if ([title isEqual:readEcg] ||
        [title isEqual:readOxi] ||
        [title isEqual:readTM] ||
        [title isEqual:readSlm]) {
        _userList = nil;
        _xuserList = nil;
        [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
    }
    if ([title isEqual:readXuserList]) {
        [self readXuserList];
    }
    if ([title isEqual:readQC]) {
        if (_xuserList) {
            [self performSegueWithIdentifier:@"gotoVTDataListViewController" sender:nil];
        }else{
            [self readXuserList];
        }
    }
    if ([title isEqual:readHC]) {
        [self performSegueWithIdentifier:@"gotoVTEXListViewController" sender:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark  --  delegate

- (void)getInfoWithResultData:(NSData *)infoData{
    if (_isInitialRequest && infoData) {
        _isInitialRequest = NO;
        _info = [VTProFileParser parseProInfoWithData:infoData];
        
        [self initFuncArray];
        [_tableView reloadData];
        
        return;
    }
    
    if (infoData) {
        VTProInfo *info = [VTProFileParser parseProInfoWithData:infoData];
        _info = info;
        [self performSegueWithIdentifier:@"gotoVTInfoViewController" sender:nil];
    }else{
    
    }
}


- (void)commonResponse:(VTProCmdType)cmdType andResult:(VTProCommonResult)result{
    if (cmdType == VTProCmdTypeSyncTime) {
        NSString *titleStr = @"Sync time success";
        NSString *actionStr = @"OK";
        if (_isDomesticCheckme) {
            titleStr = @"同步时间成功";
            actionStr = @"知道了";
        }
        if (result == VTProCommonResultSuccess) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr
                                                                           message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionStr style:UIAlertActionStyleDefault handler:nil];
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
            if (_currNEModel.event == 2) {
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
            if (_currNEModel.event == 11) {
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
        [_miniDescLab setHidden:YES];
        [_tableView setHidden:NO];
    }
    _state = state;
}

@end

