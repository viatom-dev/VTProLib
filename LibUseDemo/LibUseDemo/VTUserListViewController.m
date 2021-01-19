//
//  VTUserListViewController.m
//  LibUseDemo
//
//  Created by 杨伟超 on 2020/6/14.
//  Copyright © 2020 Viatom. All rights reserved.
//

#import "VTUserListViewController.h"

@interface VTUserListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation VTUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUserArray:(NSArray *)userArray{
    _userArray = userArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"userListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    id u = _userArray[indexPath.row];
    if ([u isMemberOfClass:[VTProUser class]]) {
        VTProUser *user = u;
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"VTProLibBundle" ofType:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithPath:imagePath];
        UIImage *image = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:[NSString stringWithFormat:@"ico%d", user.iconID] ofType:@"png"]];
        CGSize imageSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsGetImageFromCurrentImageContext();
        cell.textLabel.text = user.userName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",user.userID];
    }else{
        VTProXuser *xuser = u;
        cell.textLabel.text = xuser.userName;
        cell.detailTextLabel.text = xuser.patientID;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}


@end
