//
//  DownLoadViewController.m
//  WStarFramework
//
//  Created by jf on 16/12/23.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "DownLoadViewController.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

#define Width_Space      10.0f      // 2个按钮之间的横间距
#define IMAGE_COUNT 9   //图片个数
@interface DownLoadViewController ()
{
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
    NSMutableArray *_threads;
    
      NSLock *_lock;
//    GCD中提供了一种信号机制，也可以解决资源抢占问题
      dispatch_semaphore_t _semaphore;//定义一个信号量
}

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self layoutUI];
    
    
//    对于资源抢占的问题可以使用同步锁NSLock来解决
    
    
}
#pragma mark 界面布局
-(void)layoutUI{
    
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    NSArray * arrs = @[@"串行队列",@"并发队列",@"未按顺序",@"最后先",@"停止"];
    
    for (int j = 0; j < arrs.count; j ++) {
        //计算当前按钮的列的索引和行的索引
        float x = 5;
        float y = 500;
        float w = 50;
        float h = 30;
         NSInteger index = j % arrs.count;
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(index * (Width_Space + w) + x, y, w, h);
        
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:arrs[j] forState:UIControlStateNormal];
        button.tag = j +100;
        //添加方法
        [button addTarget:self action:@selector(loadImageWithMultiThread:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }

    
    //创建图片链接
    _imageNames=[NSMutableArray array];
//     for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++)   // 有15个线程都准备加载这9张图
    for (int i=0; i< IMAGE_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    
    
//    //初始化锁对象
//    _lock=[[NSLock alloc]init];
    
    /*初始化信号量  参数是信号量初始值
     */
    _semaphore=dispatch_semaphore_create(1);
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread:(UIButton *)button{
    
    int count=ROW_COUNT*COLUMN_COUNT;
     _threads=[NSMutableArray arrayWithCapacity:count];
    
    if (button.tag == 100) {
        /*创建一个串行队列
         第一个参数：队列名称
         第二个参数：队列类型
         */
        dispatch_queue_t serialQueue=dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);//注意queue对象不是指针类型
        //创建多个线程用于填充图片
        for (int i=0; i<count; ++i) {
            //异步执行队列任务
            dispatch_async(serialQueue, ^{
                [self loadImage:[NSNumber numberWithInt:i]];
            });
            
        }
        //非ARC环境请释放
        //    dispatch_release(seriQueue);

    }else if ( button.tag == 101){
        
        int count=ROW_COUNT*COLUMN_COUNT;
        
        /*取得全局队列
         第一个参数：线程优先级
         第二个参数：标记参数，目前没有用，一般传入0
         */
        dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //创建多个线程用于填充图片
        for (int i=0; i<count; ++i) {
            //异步执行队列任务
            dispatch_sync(globalQueue, ^{
                [self loadImage:[NSNumber numberWithInt:i]];
            });
        }
        
    }else if ( button.tag == 102) {
      
        NSMutableArray *threads=[NSMutableArray array];
        int count=ROW_COUNT*COLUMN_COUNT;
        //创建多个线程用于填充图片
        for (int i=0; i<count; ++i) {
            //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
            NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
            thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
            if(i==(count-1)){
                thread.threadPriority=1.0;
            }else{
                thread.threadPriority=0.0;
            }
            [threads addObject:thread];
        }
        
        for (int i=0; i<count; i++) {
            NSThread *thread=threads[i];
            [thread start];
        }
    }
    else if ( button.tag == 103){
        
        int count=ROW_COUNT*COLUMN_COUNT;
        //创建操作队列
        NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
        operationQueue.maxConcurrentOperationCount=5;//设置最大并发线程数
        
        NSBlockOperation *lastBlockOperation=[NSBlockOperation blockOperationWithBlock:^{
            [self loadImage:[NSNumber numberWithInt:(count-1)]];
        }];
        //创建多个线程用于填充图片
        for (int i=0; i<count-1; ++i) {
            //方法1：创建操作块添加到队列
            //创建多线程操作
            NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
                [self loadImage:[NSNumber numberWithInt:i]];
            }];
            //设置依赖操作为最后一张图片加载操作
//            假设操作A依赖于操作B，线程操作队列在启动线程时就会首先执行B操作，然后执行A
            [blockOperation addDependency:lastBlockOperation];
            
            [operationQueue addOperation:blockOperation];
            
        }
        //将最后一个图片的加载操作加入线程队列
        [operationQueue addOperation:lastBlockOperation];
        
        
        
        
//        //创建多个线程用于填充图片
//        for (int i=0; i<count; ++i){
////       //方法2     直接使用操队列添加操作
//        [operationQueue addOperationWithBlock:^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//         }];
//      }
//        
        
        
    }
    else {
        //停止
        for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
            NSThread *thread= _threads[i];
            //判断线程是否完成，如果没有完成则设置为取消状态
            //注意设置为取消状态仅仅是改变了线程状态而言，并不能终止线程
            if (!thread.isFinished) {
                [thread cancel];
                
            }
        }
    }
}
#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    
    //如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
    NSLog(@"current thread :%@",[NSThread currentThread]);
    
    int i = [index integerValue];
    
    //请求数据
    NSData *data= [self requestData:i];
    
    NSThread *currentThread=[NSThread currentThread];
    //    如果当前线程处于取消状态，则退出当前线程
    if (currentThread.isCancelled) {
        NSLog(@"thread(%@) will be cancelled!",currentThread);
        [NSThread exit];//取消当前线程
    }
    
    //更新UI界面,此处调用了GCD主线程队列的方法    TODO1
    dispatch_queue_t mainQueue= dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
    
////    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程） TODO2
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [self updateImageWithData:data andIndex:i];
//    }];
    
}


#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    
//    //对非最后一张图片加载线程休眠2秒
//    if (index!=(ROW_COUNT*COLUMN_COUNT-1)) {
//        [NSThread sleepForTimeInterval:2.0];
//    }
    
    NSData *data;
    NSString *name;
    
    /*
     没有判断争夺资源  的时候  15 张
     */
//    NSURL *url=[NSURL URLWithString:_imageNames[index]];
//    NSData *data=[NSData dataWithContentsOfURL:url];
    
   //-------  ---------- ----------- -------------
 
/**
     NSLock  方法
*/
    
    
//    //加锁
//    [_lock lock];
//    
//    if (_imageNames.count>0) {
//        name=[_imageNames lastObject];
//        [_imageNames removeObject:name];
//    }
//    //使用完解锁
//    [_lock unlock];
    
//- -- - - - - -  ----       ------- ----------   -----------  --- --  - - - - - - - - - - - - - - -
    
    
/**
     synchronized  方法
*/
    
//    //线程同步
//    @synchronized(self){
//        if (_imageNames.count>0) {
//            name=[_imageNames lastObject];
//            [NSThread sleepForTimeInterval:0.001f];
//            [_imageNames removeObject:name];
//        }
//    }
    
//- -- - - - - -  ----       ------- ----------
    
    /*信号等待
     第二个参数：等待时间
     */
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_imageNames.count>0) {
        name=[_imageNames lastObject];
        [_imageNames removeObject:name];
    }
    
    //信号通知
    dispatch_semaphore_signal(_semaphore);
    
    
    
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }

    
    return data;
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
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
