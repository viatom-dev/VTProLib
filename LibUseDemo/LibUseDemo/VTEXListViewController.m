//
//  VTEXListViewController.m
//  LibUseDemo
//
//  Created by yangweichao on 2021/2/24.
//  Copyright © 2021 Viatom. All rights reserved.
//

#import "VTEXListViewController.h"
#import "SVProgressHUD.h"

@interface VTEXListViewController ()<VTProCommunicateDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation VTEXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _listArray = [NSMutableArray array];
    [_listTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [VTProCommunicate sharedInstance].delegate = self;
    [[VTProCommunicate sharedInstance] beginReadHistoryList];
    [SVProgressHUD show];
    
}

#pragma mark --- Communicate delegate
- (void)pro_readCompleteWithData:(VTProFileToRead *)fileData{
    if (fileData.fileType == VTProFileTypeEXHistoryList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseHeartCheckList:fileData.fileData];
            [_listArray addObjectsFromArray:arr];
            [_listTableView reloadData];
        }else{
            DLog(@"Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypeEXHistoryDetail) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            [VTProFileParser parseECGDetailWithFileData:fileData.fileData callBack:^(EXEcgFileHeader header, NSMutableArray * _Nullable ecgContent) {
                // Detail data
                DLog(@"Heart rate is %d", header.hrResult);
            }];
        }else{
            DLog(@"Detail Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }
}

- (void)pro_postCurrentReadProgress:(double)progress{
    
    [SVProgressHUD showProgress:progress];
}


#pragma mark -- tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"exListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    VTProEXHistory *model = _listArray[indexPath.row];
    NSDateComponents *dc = [model valueForKey:@"dtcDate"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld", (long)dc.year, (long)dc.month, (long)dc.day, (long)dc.hour, (long)dc.minute, (long)dc.second];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VTProEXHistory *ex = _listArray[indexPath.row];
    [SVProgressHUD showProgress:0];
    [[VTProCommunicate sharedInstance] beginReadHistoryDetail:ex.recordTime];
}


@end
