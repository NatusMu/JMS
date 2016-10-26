//
//  ExtraViewController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "ExtraViewController.h"
#import "NetworkJudgeController.h"
#import "ExtraTableViewCell.h"
@interface ExtraViewController ()
{
    UITableView *_tableView;
}
@end

@implementation ExtraViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = [NSString stringWithFormat:@"特价详情--%@",_titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [backBtn setImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"ExtraTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.imgView.image = [UIImage imageNamed:@"Flash.jpg"];
    cell.titleLabel.text = _titleLabel;
    cell.descriptLabel.text = _detailLabel;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380;
    
}


-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
