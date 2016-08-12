//
//  HotWebViewController.m
//  NewsApp
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "HotWebViewController.h"
#import "AFNetworking.h"

@interface HotWebViewController ()<UIWebViewDelegate>
//创建一个web视图显示数据
@property (nonatomic, weak) UIWebView *webView;
//创建网路请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HotWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.Url);
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self loadDefaultSetting];
    // Do any additional setup after loading the view.
}
-(void)loadDefaultSetting{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    self.webView = webView;
    
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.mas_equalTo(self.tabBarController.tabBar.bounds.size.height);
    }];
    
    self.manager = [AFHTTPSessionManager manager];
    [self.manager GET:self.Url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) task.response;
        
        if (httpResponse.statusCode == 200) {
            //解析数据
            //取出需要的数组
            NSDictionary *dicNewsTemp = (NSDictionary *)responseObject;
            //判断是不是数组
            if ([dicNewsTemp isKindOfClass:[NSDictionary class]]) {
                
                NSString *str = dicNewsTemp[@"body"][@"text"];
                [self.webView loadHTMLString:str baseURL:nil];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    NSLog(@"WEBViewController死了");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /** 调整UIWebView的大小适应屏幕 */
    /** 修改百分之即可修改字体大小 */
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body') [0].style.webkitTextSizeAdjust= '100%'"];
    
    NSString *strJS = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    strJS = [NSString stringWithFormat:strJS,[UIScreen mainScreen].bounds.size];
    [webView stringByEvaluatingJavaScriptFromString:strJS];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
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
