//
//  JMSGuideViewController.m
//  JSM
//
//  Created by 黄沐 on 2016/10/10.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "JMSGuideViewController.h"
#import "JMSViewController.h"
@interface JMSGuideViewController ()<UIScrollViewDelegate>
{
    UIView *_setView;
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@end

@implementation JMSGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initGuide];
}
#pragma mark  -methods

-(void)initGuide
{
    /*
     UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
     [scrollView setContentSize:CGSizeMake(1280, 0)];
     [scrollView setPagingEnabled:YES];  //视图整页显示
     //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
     
     UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
     [imageview setImage:[UIImage imageNamed:@"0.png"]];
     [scrollView addSubview:imageview];
     
     UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 460)];
     [imageview1 setImage:[UIImage imageNamed:@"1.png"]];
     [scrollView addSubview:imageview1];
     
     UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 460)];
     [imageview2 setImage:[UIImage imageNamed:@"2.png"]];
     [scrollView addSubview:imageview2];
     UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(960, 0, 320, 460)];
     [imageview3 setImage:[UIImage imageNamed:@"3.png"]];
     imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
     [scrollView addSubview:imageview3];
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
     [button setTitle:nil forState:UIControlStateNormal];
     [button setFrame:CGRectMake(46, 371, 230, 37)];
     [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
     [imageview3 addSubview:button];
     
     [self.view addSubview:scrollView];
     */
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds)*3, 0)];
    [_scrollView setPagingEnabled:YES];//视图整页显示,是否分页
    [_scrollView setBounces:NO];//避免弹跳效果,避免把根视图露出来
    _scrollView.scrollEnabled = YES;//设置滚动
    _scrollView.delegate = self;
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [imgView1 setImage:[UIImage imageNamed:@"launcher1.jpg"]];
    [_scrollView addSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [imgView2 setImage:[UIImage imageNamed:@"launcher2.jpg"]];
    [_scrollView addSubview:imgView2];
    
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [imgView3 setImage:[UIImage imageNamed:@"launcher3.jpg"]];
    [_scrollView addSubview:imgView3];
    
    UIView *linearView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-47-10, self.view.frame.size.width*3, 2)];
    linearView.backgroundColor = [UIColor whiteColor];
    
    
    [_scrollView addSubview:linearView];
    
#pragma mark -PageControl
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(5, 20, self.view.frame.size.width, 20)];
    //设置总页数
    _pageControl.numberOfPages = 3;
    //设置当前页数
    _pageControl.currentPage = 0;
    // 设置总页数指示色
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    // 设置当前页数指示色
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //
    
    [self.view addSubview:_scrollView];
    
    _setView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-47-10, self.view.frame.size.width, 47)];
    _setView.backgroundColor = [UIColor clearColor];
    
    
    
    [self.view addSubview:_setView];
    [_setView addSubview:_pageControl];
    _button1 = [self button1];
    _button2 = [self button2];
    _button3 = [self button3];
    [_setView addSubview:_button1];
    [_setView addSubview:_button2];
    [_setView addSubview:_button3];
    _button1.hidden = YES;
    _button2.hidden = NO;
    _button3.hidden = NO;
    
}
#pragma mark  -methods


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width;
    if(_pageControl.currentPage == 2)
    {
        _button1.hidden = NO;
        _button2.hidden = YES;
        _button3.hidden = YES;
    }
    else
    {
        _button1.hidden = YES;
        _button2.hidden = NO;
        _button3.hidden = NO;
    }
}

#pragma mark  -Getters
-(UIButton *)button1
{
    if(!_button1)
    {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
        [_button1 setTitle:@"立即进入" forState:UIControlStateNormal];
        [_button1 setFrame:CGRectMake(_setView.frame.size.width-75-20, 15, 100, 25)];
        [_button1 addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
        _button1.titleLabel.font = [UIFont fontWithName:@"Times" size:17];
        
    }
    return _button1;
}

-(UIButton *)button2
{
    if(!_button2)
    {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"跳过" forState:UIControlStateNormal];
        [_button2 setFrame:CGRectMake(0, 15, 100, 25)];
        [_button2 addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
        _button2.titleLabel.font = [UIFont fontWithName:@"Times" size:17];
    }
    return _button2;
}

-(UIButton *)button3
{
    if(!_button3)
    {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setImage:[UIImage imageNamed:@"rightarrow.png"] forState:UIControlStateNormal];
        [_button3 setFrame:CGRectMake(_setView.frame.size.width-75, 15, 25, 25)];
        [_button3 addTarget:self action:@selector(respondsToButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button3;
    
}


- (void)firstpressed
{
    //点击button跳转到根视图
    JMSViewController *jjView = [[JMSViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:jjView];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}
-(void)respondsToButton
{
    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width*(_pageControl.currentPage+1), 0) animated:YES];
    
    
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
