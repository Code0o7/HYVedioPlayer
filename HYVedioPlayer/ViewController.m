//
//  ViewController.m
//  HYVedioPlayer
//
//  Created by MrChen on 2019/1/6.
//  Copyright © 2019 MrChen. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

#define ScWidth [UIScreen mainScreen].bounds.size.width
#define ScHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

// 返回按钮
@property (nonatomic, weak) UIButton *backButton;

// 前进按钮
@property (nonatomic, weak) UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSubviews];
    [self loadWeb];
}

- (void)createSubviews
{
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scrollView.bounces = NO;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    // 控制前进后退按钮
    CGFloat h = 40.0;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScHeight - h, ScWidth, h)];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:bgView];
    
    // 返回箭头
    CGFloat margin = 40.0;
    CGFloat btnY = 0;
    CGFloat btnW = h;
    CGFloat backBtnX = (ScWidth - btnW * 2.0 - margin) * 0.5;
    CGFloat forwardBtnX = backBtnX + btnW + margin;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(backBtnX, btnY, btnW, h)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"unback"] forState:UIControlStateDisabled];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.enabled = NO;
    [bgView addSubview:backBtn];
    self.backButton = backBtn;
    
    // 向前按钮
    UIButton *forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(forwardBtnX, btnY, btnW, h)];
    [forwardBtn setBackgroundImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [forwardBtn setBackgroundImage:[UIImage imageNamed:@"unforward"] forState:UIControlStateDisabled];
    [forwardBtn addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
    forwardBtn.enabled = NO;
    [bgView addSubview:forwardBtn];
    self.forwardButton = forwardBtn;
}

- (void)loadWeb
{
    NSString *urlStr = @"http://192.168.0.105:8080/vedio";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}


/**
 * 返回
 */
- (void)back
{
    [self.webView goBack];
}

/**
 * 前进
 */
- (void)forward
{
    [self.webView goForward];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // 数据加载完成
    self.backButton.enabled = webView.canGoBack;
    self.forwardButton.enabled = webView.canGoForward;
}

@end
