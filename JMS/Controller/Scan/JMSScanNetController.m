//
//  JMSScanNetController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "JMSScanNetController.h"
//网路判断类
#import "NetworkJudgeController.h"
@interface JMSScanNetController ()
{
    NSString *_stringValue;
    UIWebView *_webView;
}
@end

@implementation JMSScanNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    NetworkJudgeController *vc = [[NetworkJudgeController alloc]init];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [backBtn setImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    if ([vc ConnectedToNetwork]) {//判断是否可以上网
        //可用 接口调用
        
        NSArray *b = [_stringValue componentsSeparatedByString:@"="];
        NSString *code;
        if(b.count > 0)
        {
            code = [b objectAtIndex:b.count-1];
            
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"二维码不识别" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        
        NSString *urlString = [NSString stringWithFormat:@"http://jiumeisheng.com/index.php?m=news&a=view&l=m&id=%@",code];
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    } else{
        //不可用
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接有误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
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
