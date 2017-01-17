//
//  TAPViewController.m
//  WStarFramework
//
//  Created by jf on 16/12/22.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "TAPViewController.h"
#import "TAPromotee.h"

#import "DownLoadViewController.h"
@interface TAPViewController ()<NSURLConnectionDataDelegate,NSURLSessionDownloadDelegate>
{
    NSFileHandle * _writeHandle;
    NSURLConnection *_connection;
}
@property (weak, nonatomic) IBOutlet UILabel *pgLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progerssView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) NSMutableData* fileData;  //文件数据
/**
 *  文件的总长度
 */
@property (nonatomic, assign) long long totalLength;
@property (nonatomic, assign) long long currentLength;  //当前的长度
@end

@implementation TAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)showAdd:(id)sender {
    
    // 361309726  Pages
    // 284882215  Facebook
    // 822702909  Daylight
    [TAPromotee showFromViewController:self appId:284882215 caption:@"Sun clock in your pocket" completion:^(TAPromoteeUserAction userAction) {
        [self handleUserAction:userAction];
    }];

}
- (IBAction)showWithCustom:(id)sender {
    [TAPromotee showFromViewController:self appId:361309726 caption:@"Your Battlefield soldier's companion" backgroundImage:[UIImage imageNamed:@"sample-app-background"] completion:^(TAPromoteeUserAction userAction) {
        [self handleUserAction:userAction];
    }];
}
- (void)handleUserAction:(TAPromoteeUserAction)userAction {
    switch (userAction) {
        case TAPromoteeUserActionDidClose:
            NSLog(@"关闭");
            break;
        case TAPromoteeUserActionDidInstall:
            NSLog(@"添加");
            break;
        default:
            break;
    }
}
- (IBAction)operationClick:(id)sender {
    
////    用NSOpertion和NSOpertionQueue处理A、B、C三个线程，要求执行完A、B后才能执行C
//    
//    //1 创建对列
//     NSOperationQueue * queue =  [[NSOperationQueue alloc]init];
//    //2.     3个操作
//    //2. 创建3个操作
//    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"operationA---");
//    }];
//
//    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"operationB---");
//    }];
//   
//    
//    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"operationC---");
//    }];
// 
//
//    //3. 添加依赖
//    [operationC addDependency:operationA];
//    [operationC addDependency:operationB];
//        // 最大并发数为3
//    [queue setMaxConcurrentOperationCount:3];
//    //4. 执行操作
//    [queue addOperation:operationA];
//    [queue addOperation:operationB];
//    [queue addOperation:operationC];

    
    
    // 初始化一个对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"1 ----------：%@",[NSThread currentThread]);
    }];
    // 再添加3操作
    [operation addExecutionBlock:^() {
        NSLog(@"2 ----------：%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^() {
        NSLog(@"3 ---------：%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^() {
        NSLog(@"4 -----------：%@", [NSThread currentThread]);
    }];
    // 开始执行任务
    [operation start];
    
}
- (IBAction)therdClick:(id)sender {
    
    DownLoadViewController * down = [[DownLoadViewController alloc]init];
    [self.navigationController pushViewController:down animated:YES];
}
//下载图片
- (IBAction)downLoadImageClick:(id)sender {
    
    NSURL* url = [NSURL URLWithString:@"https://picjumbo.imgix.net/HNCK8461.jpg?q=40&w=1650&sharp=30"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        self.imageView.image = [UIImage imageWithData:data];
    }];
    
}
//断点续传

- (IBAction)btnClicked:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"];
    // 1.得到session对象
    NSURLSession* session = [NSURLSession sharedSession];
      // 2.创建一个task，任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         // data 为返回数据
        NSLog(@"data -----%@",data);
    }];
    [dataTask resume];
}
//暂停
- (IBAction)stopClick:(UIButton *)sender {
    // 状态取反
    sender.selected = !sender.isSelected;
    
    if (sender.selected) {
      // 继续（开始）下载
        
        // 1.URL
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080//term_app/hdgg.zip"];
        
        // 2.请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置请求头
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
    }else {
        // 暂停
        [_connection cancel];
        _connection = nil;
    }
}

#pragma mark --NSURLConnectionDataDelegate
/**
 *  请求失败时调用（请求超时、网络异常）
 *
 *  @param error      错误原因
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError ----%@",error);
}
/**
 *  1.接收到服务器的响应就会调用
 *
 *  @param response   响应
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    self.fileData = [NSMutableData data];
    // 获取要下载的文件的大小
    self.totalLength = response.expectedContentLength;
    NSLog(@"didReceiveResponse ---------%lld",self.totalLength);
    
    
    //文件路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [cache stringByAppendingPathComponent:response.suggestedFilename];
    //创建一个空的文件到沙盒
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createFileAtPath:filepath contents:nil attributes:nil];
    
    //创建一个用来写数据的文件句柄对象
     _writeHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
    
}
/**
 *  2.当接收到服务器返回的实体数据时调用（具体内容，这个方法可能会被调用多次）
 *
 *  @param data       这次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    //移到文件的最后面
    [_writeHandle seekToEndOfFile];
    //将数据写入沙盒
    [_writeHandle writeData:data];
    
    //累计写入文件的长度
    self.currentLength += data.length;
    
    [self.fileData appendData:data];
    self.progerssView.progress = (double)self.fileData.length / self.totalLength;
    
    long long ff   =  self.currentLength/self.totalLength;
    
    NSLog(@"didReceiveData ---------%f ---%lld ---%lld",self.progerssView.progress,_currentLength,ff);
}

/**
 *  3.加载完毕后调用（服务器的数据已经完全返回后）
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSURLResponse *response = [[NSURLResponse alloc] init];

    // 拼接文件路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [cache stringByAppendingPathComponent:response.suggestedFilename];
    
    // 写到沙盒中
    [self.fileData writeToFile:file atomically:YES];
    
    NSLog(@"connectionDidFinishLoading ---------");
    
    self.currentLength = 0;
    self.totalLength = 0;
    //关闭文件
    [_writeHandle closeFile];
    _writeHandle = nil;
}

#pragma mark -- NSURLSessionDownloadDelegate
/**
 *  下载完毕会调用
 *
 *  @param location     文件临时地址
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
}
/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.pgLabel.text = [NSString stringWithFormat:@"下载进度:%f",(double)totalBytesWritten/totalBytesExpectedToWrite];
}

/**
 *  恢复下载后调用，
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
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
