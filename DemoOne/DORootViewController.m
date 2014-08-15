//
//  DORootViewController.m
//  DemoOne
//
//  Created by Abbie on 2014/8/13.
//  Copyright (c) 2014年 LiVEBRiCKS. All rights reserved.
//

#import "DORootViewController.h"
#define URL @"http://www.indexbricks.com/data/get_update.php?function_code=Intro&store=livebricks&version=0&language=TW"

@interface DORootViewController ()
@property (strong, nonatomic) NSDictionary *responseDic;

@end

@implementation DORootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showTextView.editable = NO;
    //設定scrollview的滾動範圍
    self.showScrollView.contentSize = CGSizeMake(1000, 400);
    //分頁效果
    self.showScrollView.pagingEnabled = YES;
    //水平方向滾動
    self.showScrollView.showsHorizontalScrollIndicator = NO;
    //垂直方向滾動
    self.showScrollView.showsVerticalScrollIndicator = NO;
    
    //以dic從URL接資料，所取得的是第二層每個dic的資料
    self.responseDic = [self getResultsDic:URL];
    //因第一層為array形態，故要先創立一個array形態變數先取得第一層資料（livebricks)
    NSArray *responseArray = [self.responseDic objectForKey:@"livebricks"];

    for (int i=0; i <[responseArray count] ; i++) {
    NSDictionary *detailDic = [responseArray objectAtIndex:i];
    self.showTextView.text = [detailDic objectForKey:@"description"];
        
    NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[detailDic objectForKey:@"image_url"]]];
    UIImage *img = [UIImage imageWithData:imagedata];
    self.showImageView.image = img;
    }
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScrollToTop:(UIScrollView *)showScrollView
//{
//    NSLog(@"scrollViewDidScrollToTop");
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)showScrollView
//{
//    
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)showScrollView
//{
//    NSLog(@"scrollViewWillBeginDragging");
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"scrollViewDidEndDragging willDecelerate");
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)showScrollView{
//    NSLog(@"scrollViewWillBeginDecelerating");
//}
////tell delegate，scrollview已結束運作，減速移動
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)showScrollView{
//    NSLog(@"scrollViewDidEndDecelerating");
//}

#pragma mark - setURL

//選擇並建立最後要回傳的資料形態 (ex:dic)
- (NSDictionary *)getResultsDic:(NSString *)jsonString{
//對URL提出request，過程中因原URL為一字串，故需要進行轉型（requset<-URL<-string)
   NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:jsonString]];
//若回傳過程中有錯誤，則回傳nil
   NSError *err = nil;
//接著需要取得資料，與URLConnect
   NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
//因取得的資料無法被掌控，所以需要轉換成能夠使用的資料形態，此轉換為dic
   NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&err];
//最後回傳dic
   return jsonDic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
