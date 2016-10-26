//
//  DetailViewController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "DetailViewController.h"
#import "NetworkJudgeController.h"
#import "JMSTableViewCell.h"
#import "ExtraViewController.h"
@interface DetailViewController ()
{
    NSArray *_arr;
    NSDictionary *_dic;
    NSDictionary *_arrdic;
    UITableView *_tableView;
    
}
@end

@implementation DetailViewController

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
    NetworkJudgeController *vc = [[NetworkJudgeController alloc]init];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [backBtn setImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    if ([vc ConnectedToNetwork]) {//判断是否可以上网
        //可用 接口调用
        _arr = [NSArray array];
        _arr = [self httpPOST:self.strTitle];
        NSLog(@"接口返回数据:%@",_arr);
        [self.tableView registerNib:[UINib nibWithNibName:@"JMSTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        self.title = [NSString stringWithFormat:@"%@",_strTitle];
    } else{
        //不可用
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接有误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (NSArray *)httpPOST:(NSString *)string
{
    //拼接url （域名＋路径）
    NSString *URLStr = [NSString stringWithFormat:@"http://114.55.2.92/shouji/index.php/?m=Mobile&a=getNews"];
    //url字符串 转 url
    NSURL *url = [NSURL URLWithString:URLStr];
    //声明 网络请求对象  （请求url）
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求方式
    [request setHTTPMethod:@"POST"];
    //声明请求参数的字符串
    NSString *DataStr = [NSString stringWithFormat:@"type=%@",string];
    //将参数字符串 转成 utf-8的数据类型
    NSData *data = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
    //将参数数据添加到 网络请求中
    [request setHTTPBody:data];
    //发起请求 并接受返回值
    NSData *dataHui = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString * sre = [[NSString alloc]initWithData:dataHui encoding:NSUTF8StringEncoding];
    
    NSData *dd = [sre dataUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"1111:%@",sre);
    //判断是否获取返回成功（也是判断是否网络请求成功）
    if (dataHui != nil) {
        //json 解析 网络请求返回的 数据（一般都是用json 返回   特殊情况后台程序猿 会声明协议文档）
        
        _dic = [NSJSONSerialization JSONObjectWithData:dd options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"接口返回数据::%@",_dic);
        
        // NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"data"]];
        NSArray *arr = [_dic objectForKey:@"data"];
        _arrdic = arr[0];
        //NSString *str = [NSString stringWithFormat:@"%@",[arrdic objectForKey:@"id"]];
        //NSLog(@"判断是否获取成功:%@",str);
        //NSLog(@"long_name:%@",[dic objectForKey:@"department_name"]);
        return arr;
    }else{
        //获取接口返回失败  或者是 网络请求失败
        NSLog(@"数据获取失败");
        return nil;
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_arr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    JMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *dicCell = _arr[indexPath.row];
    
    cell.titleLabel.text = [dicCell objectForKey:@"Title"];
    cell.descriptLabel.text = [dicCell objectForKey:@"Description"];
    
    
    NSString *str = [NSString stringWithFormat:@"http://114.55.2.92/%@",[dicCell objectForKey:@"Icon_Url"]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
    if (image != nil) {
        cell.imgVIew.image = image;
    }else{
        cell.imgVIew.image = [UIImage imageNamed:@"Flash.jpg"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 277;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _arr[indexPath.row];
    ExtraViewController *extraVc = [[ExtraViewController alloc]init];
    extraVc.titleLabel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
    extraVc.detailLabel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Detail"]];
    [self.navigationController pushViewController:extraVc animated:YES];
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
