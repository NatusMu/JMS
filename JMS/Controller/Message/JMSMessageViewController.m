//
//  JMSMessageViewController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/19.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "JMSMessageViewController.h"
#import "NetworkJudgeController.h"
#import "DetailViewController.h"
static NSString *const kReusableCellIdentifier = @"identifier";
@interface JMSMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSData *_dataHui;
    NSData *_dd;
    NSDictionary *_dic;
    NSArray *_arr;
    NSDictionary *_arrdic;
}
@property (nonatomic,copy) UITableView *tableView; /**< 表格视图 */
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *descripStr;
@end

@implementation JMSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NetworkJudgeController *vc = [[NetworkJudgeController alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [backBtn setImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    if ([vc ConnectedToNetwork]) {//判断是否可以上网
        //url字符串 转 url
        NSURL *url = [NSURL URLWithString:@"http://114.55.2.92/shouji/index.php/?m=Mobile&a=getNewsMenu"];
        //声明 网络请求对象  （请求url）
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //设置请求方式
        [request setHTTPMethod:@"POST"];
        //声明请求参数的字符串
        NSString *DataStr = [NSString stringWithFormat:@""];
        //将参数字符串 转成 utf-8的数据类型
        NSData *data = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
        //将参数数据添加到 网络请求中
        [request setHTTPBody:data];
        //发起请求 并接受返回值
        _dataHui = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString * sre = [[NSString alloc]initWithData:_dataHui encoding:NSUTF8StringEncoding];
        _dd = [sre dataUsingEncoding:NSUTF8StringEncoding];
        // NSLog(@"1111:%@",sre);
        //判断是否获取返回成功（也是判断是否网络请求成功）
        if (_dataHui != nil)
        {
            //json 解析 网络请求返回的 数据（一般都是用json 返回   特殊情况后台程序猿 会声明协议文档）
            
            _dic = [NSJSONSerialization JSONObjectWithData:_dd options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"接口返回数据::%@",_dic);
            
            // NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"data"]];
            //           _arr = [_dic objectForKey:@"data"];
            //           _arrdic = _arr[2];
            //           NSString *str = [NSString stringWithFormat:@"%@",[_arrdic objectForKey:@"Title"]];
            //        NSLog(@"%@",str);
            
        }
        else
        {
            //获取接口返回失败  或者是 网络请求失败
            NSLog(@"数据获取失败");
        }
        
        [self.view addSubview:self.tableView];
    } else{
        //不可用
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接有误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark  -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataHui != nil)
    {
        _dic = [NSJSONSerialization JSONObjectWithData:_dd options:NSJSONReadingMutableContainers error:nil];
        _arr = [_dic objectForKey:@"data"];
    }
    return [_arr count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 单元格重用机制
    // 首先在表格视图中根据标识符寻找可重用的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellIdentifier];
    // 判断是否找到可重用的单元格
    if (!cell) {
        // 如果没有找到则新建单元格
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReusableCellIdentifier] ;
    }
    
    NSDictionary *dicCell = _arr[indexPath.row];
    
    cell.textLabel.text = [dicCell objectForKey:@"Title"];
    cell.textLabel.font = [UIFont fontWithName:@"Times" size:20];
    cell.detailTextLabel.text = [dicCell objectForKey:@"Description"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Times" size:15];
    
    NSString *str = [NSString stringWithFormat:@"http://114.55.2.92/%@",[dicCell objectForKey:@"Icon_Url"]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
    if (image != nil) {
        cell.imageView.image = image;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Flash.jpg"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
// 这是头部高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}

#pragma mark *** Getters ***
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        // 设置背景颜色
        _tableView.backgroundColor = [UIColor clearColor];
        // 设置代理
        _tableView.delegate = self;
        // 设置数据源
        _tableView.dataSource = self;
        // 设置分割线样式
        // 由于iPhone6S plus的分辨率较高，开发的时候通常都使用command + 3 或者 command + 4 缩小模拟器显示，这个时候就相当于把plus的分辨率压缩了所以我们会看不到分割线，解决办法就是把模拟器放大就可以了，选中模拟器按command + 1把模拟器放大就可以了。
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        // 设置能否回弹
        _tableView.bounces = NO;
        
    }
    return _tableView;
}

#pragma mark *** UITableViewDelegate ***
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _arr[indexPath.row];
    
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    
    detailVc.strTitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
    [self.navigationController pushViewController:detailVc animated:YES];
    // 设置选中时单元格背景颜色
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor cyanColor];
    
    
}
-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
