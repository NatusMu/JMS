//
//  NetworkController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/13.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "NetworkController.h"
#import "JMSGuideViewController.h"
#import "JMSViewController.h"
#import "NetworkJudgeController.h"
@interface NetworkController ()<NSURLSessionDataDelegate>
{
    NSData *data_back;
    NSData *data_change;
    NSDictionary *dic;
    NSArray *arr;
    NSDictionary *arrdic;
    UIScreen *currentScreen;
    
}
@end

@implementation NetworkController

- (void)viewDidLoad {
    [super viewDidLoad];
    NetworkJudgeController *vc = [[NetworkJudgeController alloc]init];
    if ([vc ConnectedToNetwork]) {//判断是否可以上网
        //可用 接口调用
        //1.拼接url （域名＋路径）
        //NSString *URLStr = [NSString stringWithFormat:@"http://114.55.2.92/shouji/index.php/?m=Mobile&a=mobileAd"];
        //在这里并没有设置缓存
        
        //1.url字符串 转 url
        NSURL *url = [NSURL URLWithString:@"http://114.55.2.92/shouji/index.php/?m=Mobile&a=mobileAd"];
        
        //2.构造Request  （请求url） 基础缓存策略
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        //2.1.设置请求方式为 POST
        [request setHTTPMethod:@"POST"];
        //[request setTimeoutInterval:60]; 超时设置
        //2.2设置请求头
        //[request setAllHTTPHeaderFields:nil];
        //2.3 声明请求参数的字符串 设置请求体
        NSString *DataStr = [NSString stringWithFormat:@"type=移动端广告位	"];
        //将参数字符串 转成 utf-8的数据类型
        NSData *data = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
        //将参数数据添加到 网络请求中
        [request setHTTPBody:data];
        
//        //3.发起请求 并接受返回值
//        NSURLSession * session =[NSURLSession sharedSession];
//        // 通过NSURL创建任务（task）
//        NSURLSessionDataTask *task =[session dataTaskWithURL:url];
//        // 任务开启
//        [task resume];
//        
//        // 任务暂停
//        [task suspend];
        
        //4.task NSURLConnection接受数据
        data_back = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString * sre = [[NSString alloc]initWithData:data_back encoding:NSUTF8StringEncoding];
        data_change = [sre dataUsingEncoding:NSUTF8StringEncoding];
        // NSLog(@"1111:%@",sre);
        //判断是否获取返回成功（也是判断是否网络请求成功）
        if (data_back != nil)
        {
            //json 解析 网络请求返回的 数据（一般都是用json 返回   特殊情况后台程序猿 会声明协议文档）
            dic = [NSJSONSerialization JSONObjectWithData:data_change options:NSJSONReadingMutableContainers error:nil];
            int x = arc4random() %3;//取0到2 整数
            arr = [dic objectForKey:@"data"];
            NSLog(@"%s",arr);
            arrdic = arr[x];
            NSString *str = [NSString stringWithFormat:@"http://114.55.2.92/%@",[arrdic objectForKey:@"S_Image"]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
            currentScreen = [UIScreen mainScreen];
            //NSLog(@"applicationFrame.size.height = %f",currentScreen.applicationFrame.size.height);
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, currentScreen.applicationFrame.size.width, currentScreen.applicationFrame.size.height+20)];
            imgView.image = image;
            [self.view addSubview:imgView];
    
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(newtimeMethods) userInfo:nil repeats:NO];
            
            //NSLog(@"%@",str);
        }
        else
        {
            //获取接口返回失败  或者是 网络请求失败
            //        NSLog(@"数据获取失败");
        }
        
    } else{
        //不可用
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接有误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)newtimeMethods
{
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstlaunch"]==)
//    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstlaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        JMSGuideViewController *userGuideViewController = [[JMSGuideViewController alloc] init];
        [self presentViewController:userGuideViewController animated:NO completion:nil];
//    }
//    else
//    {
//        NSLog(@"不是第一次启动");
//        //如果不是第一次启动的话,使用LoginViewController作为根视图
//        JMSViewController *jjView = [[JMSViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:jjView];
//        [self presentViewController:nav animated:NO completion:nil];
//    }

}
//发送请求，代理方法
//-(void)delegateTest
//{
//    //1.确定请求路径
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
//    
//    //2.创建请求对象
//    //请求对象内部默认已经包含了请求头和请求方法（GET）
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    //3.获得会话对象,并设置代理
//    /*
//     第一个参数：会话对象的配置信息defaultSessionConfiguration 表示默认配置
//     第二个参数：谁成为代理，此处为控制器本身即self
//     第三个参数：队列，该队列决定代理方法在哪个线程中调用，可以传主队列|非主队列
//     [NSOperationQueue mainQueue]   主队列：   代理方法在主线程中调用
//     [[NSOperationQueue alloc]init] 非主队列： 代理方法在子线程中调用
//     */
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    //4.根据会话对象创建一个Task(发送请求）
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
//    
//    //5.执行任务
//    [dataTask resume];
//}
//
////1.接收到服务器响应的时候调用该方法
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
//{
//    //在该方法中可以得到响应头信息，即response
//    NSLog(@"didReceiveResponse--%@",[NSThread currentThread]);
//    
//    //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
//    //默认是取消的
//    /*
//     NSURLSessionResponseCancel = 0,        默认的处理方式，取消
//     NSURLSessionResponseAllow = 1,         接收服务器返回的数据
//     NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
//     NSURLSessionResponseBecomeStream        变成一个流
//     */
//    
//    completionHandler(NSURLSessionResponseAllow);
//}
//
////2.接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
//{
//    NSLog(@"didReceiveData--%@",[NSThread currentThread]);
//    
//    //拼接服务器返回的数据
//    [self.responseData appendData:data];
//}
//
////3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
//{
//    NSLog(@"didCompleteWithError--%@",[NSThread currentThread]);
//    
//    if(error == nil)
//    {
//        //解析数据,JSON解析请参考http://www.cnblogs.com/wendingding/p/3815303.html
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:nil];
//        NSLog(@"%@",dict);
//    }
//}
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
