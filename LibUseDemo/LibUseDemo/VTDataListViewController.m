//
//  VTDataListViewController.m
//  LibUseDemo
//
//  Created by viatom on 2020/6/18.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import "VTDataListViewController.h"
#import "SVProgressHUD.h"

@interface VTDataList : NSObject

@property (nonatomic, assign) BOOL isExpand;

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation VTDataList


- (instancetype)init{
    self = [super init];
    if (self) {
        self.list = [NSMutableArray arrayWithCapacity:10];
        self.isExpand = NO;
    }
    return self;
}

@end




@interface VTDataListViewController ()<UITableViewDelegate, UITableViewDataSource, VTProCommunicateDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation VTDataListViewController
{
    NSInteger _index; // index for download list data.
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataList;
}

- (void)setUserList:(NSArray<VTProUser *> *)userList{
    _userList = userList;
    for (int i = 0; i < userList.count; i ++) {
        VTDataList *list = [[VTDataList alloc] init];
        [self.dataList addObject:list];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [_listTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [VTProCommunicate sharedInstance].delegate = self;
    [SVProgressHUD show];
    _index = 0;
    [self downloadList:_index];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)downloadList:(NSInteger)index{
    _index = index;
    if (index == _userList.count && _userList != nil) {
        _index = 0;
        [SVProgressHUD dismiss];
        [_listTableView reloadData];
        return;
    }
    VTProUser *user = nil;
    if (_userList) {
        user = _userList[_index];
    }
    [[VTProCommunicate sharedInstance] beginReadFileListWithUser:user fileType:[self dataTypeMapToFileType]];
}

- (VTProFileType)dataTypeMapToFileType{
    switch (_dataType) {
       case 3:
           return VTProFileTypeDlcList;
       case 4:
           return VTProFileTypeEcgList;
       case 5:
           return VTProFileTypeSpO2List;
       case 6:
           return VTProFileTypeBpList;
       case 7:
           return VTProFileTypeBgList;
       case 8:
           return VTProFileTypeTmList;
       case 9:
           return VTProFileTypeSlmList;
       case 10:
           return VTProFileTypePedList;
       default:
           break;
    }
    return VTProFileTypeNone;
}



#pragma mark -- sdk response

- (void)readCompleteWithData:(VTProFileToRead *)fileData{
    if(fileData.fileType == VTProFileTypeDlcList) {
        if(fileData.enLoadResult == VTProFileLoadResultSuccess){
            NSArray *arr = [VTProFileParser parseDlcList_WithFileData:fileData.fileData];
            VTDataList *list = _dataList[_index];
            [list.list addObjectsFromArray:arr];
            [_dataList replaceObjectAtIndex:_index withObject:list];
        }
        _index ++ ;
        [self downloadList:_index];
    }else if (fileData.fileType == VTProFileTypeEcgList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseEcgList_WithFileData:fileData.fileData];
            [self.dataList addObjectsFromArray:arr];
            [_listTableView reloadData];
        }else{
            DLog(@"Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypeSpO2List) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseSPO2List_WithFileData:fileData.fileData];
            [self.dataList addObjectsFromArray:arr];
            [_listTableView reloadData];
            
        }else{
            DLog(@"Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypeBpList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseNIBPList_WithFileData:fileData.fileData];
            VTDataList *list = _dataList[_index];
            [list.list addObjectsFromArray:arr];
            [_dataList replaceObjectAtIndex:_index withObject:list];
        }
        _index ++ ;
        [self downloadList:_index];
    }else if (fileData.fileType == VTProFileTypeBgList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseBloodSugerList_WithFileData:fileData.fileData];
            VTDataList *list = _dataList[_index];
            [list.list addObjectsFromArray:arr];
            [_dataList replaceObjectAtIndex:_index withObject:list];
        }
        _index ++ ;
        [self downloadList:_index];
    }else if (fileData.fileType == VTProFileTypeTmList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseTempList_WithFileData:fileData.fileData];
            [self.dataList addObjectsFromArray:arr];
            [_listTableView reloadData];
        }else{
            DLog(@"Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypeSlmList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parseSLMList_WithFileData:fileData.fileData];
            [self.dataList addObjectsFromArray:arr];
            [_listTableView reloadData];
        }else{
            DLog(@"Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypePedList) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            NSArray *arr = [VTProFileParser parsePedList_WithFileData:fileData.fileData];
            VTDataList *list = _dataList[_index];
            [list.list addObjectsFromArray:arr];
            [_dataList replaceObjectAtIndex:_index withObject:list];
        }
        _index ++ ;
        [self downloadList:_index];
    }else if (fileData.fileType == VTProFileTypeEcgDetail) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            VTProEcgDetail *detail = [VTProFileParser parseEcg_WithFileData:fileData.fileData];
            DLog(@"%@",detail);
        }else{
            DLog(@"Detail Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }else if (fileData.fileType == VTProFileTypeSlmDetail) {
        if (fileData.enLoadResult == VTProFileLoadResultSuccess) {
            VTProSlmDetail *detail = [VTProFileParser parseSLMData_WithFileData:fileData.fileData];
            DLog(@"%@",detail);
        }else{
            DLog(@"Detail Error %ld", (long)fileData.enLoadResult);
        }
        [SVProgressHUD dismiss];
    }
}

- (void)postCurrentReadProgress:(double)progress{
    
    [SVProgressHUD showProgress:progress];
}


#pragma mark -- tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_userList) {
        return _userList.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_userList) {
        VTDataList *list = _dataList[section];
        if (list.isExpand) {
            return list.list.count;
        }else{
            return 0;
        }
    }
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dataListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    id model ;
    NSString *str = @"";
    if (_userList) {
        VTDataList *list = _dataList[indexPath.section];
        model = list.list[indexPath.row];
        str = @"\t";
    }else{
        model = _dataList[indexPath.row];
    }
    NSDateComponents *dc = [model valueForKey:@"dtcDate"];
    if ([self dataTypeMapToFileType] == VTProFileTypeDlcList ||
        [self dataTypeMapToFileType] == VTProFileTypeEcgList ||
        [self dataTypeMapToFileType] == VTProFileTypeSlmList) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld-%02ld-%02ld %02ld:%02ld:%02ld", str, (long)dc.year, (long)dc.month, (long)dc.day, (long)dc.hour, (long)dc.minute, (long)dc.second];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    headerView.tag = section ;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 300, 30)];
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.text = [_userList[section] userName];
    [headerView addSubview:lab];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExpand:)];
    [headerView addGestureRecognizer:tap];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model ;
    if (_userList) {
        VTDataList *list = _dataList[indexPath.section];
        model = list.list[indexPath.row];
    }else{
        model = _dataList[indexPath.row];
    }
    if ([self dataTypeMapToFileType] == VTProFileTypeDlcList ) {
        VTProDlc *dlc = (VTProDlc *)model;
        [SVProgressHUD showProgress:0];
        [[VTProCommunicate sharedInstance] beginReadDetailFileWithObject:dlc fileType:VTProFileTypeEcgDetail];
        
    }else if ([self dataTypeMapToFileType] == VTProFileTypeEcgList) {
        VTProEcg *ecg = (VTProEcg *)model;
        [SVProgressHUD showProgress:0];
        [[VTProCommunicate sharedInstance] beginReadDetailFileWithObject:ecg fileType:VTProFileTypeEcgDetail];
        
    } else if ([self dataTypeMapToFileType] == VTProFileTypeSlmList) {
        VTProSlm *slm = (VTProSlm *)model;
        [SVProgressHUD showProgress:0];
        [[VTProCommunicate sharedInstance] beginReadDetailFileWithObject:slm fileType:VTProFileTypeSlmDetail];
    }else {
        DLog(@"No detail data");
        return;
    }
}


#pragma mark -- tap

- (void)tapExpand:(UITapGestureRecognizer *)recognizer{
    NSInteger section = recognizer.view.tag;
    VTDataList *list = _dataList[section];
    list.isExpand = !list.isExpand;
    [_dataList replaceObjectAtIndex:section withObject:list];
    [_listTableView reloadData];
}



@end
