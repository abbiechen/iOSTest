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
    
    //設定scrollview的滾動範圍
    self.showScrollView.contentSize = CGSizeMake(self.showScrollView.frame.size.width*9, self.showScrollView.frame.size.height);
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
    
    NSDictionary *detailDic;
    NSData *imagedata;
    UIImage *img ;
    
    for (int i = 0; i <[responseArray count]; i++) {
        //呈現showTextView的text
        detailDic = [responseArray objectAtIndex:i];
        self.showTextView.text = [detailDic objectForKey:@"description"];
        
        //另建立虛擬的show2TextView
        CGRect textViewframe;
        textViewframe.origin.x = self.showScrollView.frame.size.width*i+20;
        textViewframe.origin.y = 300;
        textViewframe.size = self.showTextView.frame.size;
        
        UITextView *show2TextView= [[UITextView alloc]initWithFrame:textViewframe];
        show2TextView.text = [detailDic objectForKey:@"description"];
        [self.showScrollView addSubview:show2TextView];
        show2TextView.editable = NO;
        
        
        //因資料形態非string，故先做資料形態轉換，再呈現showImageView的image
        imagedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:[detailDic objectForKey:@"image_url"]]];
        img = [UIImage imageWithData:imagedata];
        self.showImageView.image = img;
        
        //另建立虛擬的show2ImageView
        CGRect imageViewframe;
        imageViewframe.origin.x = self.showScrollView.frame.size.width*i+20;
        imageViewframe.origin.y = 46;
        imageViewframe.size = self.showImageView.frame.size;
        
        UIImageView *show2ImageView = [[UIImageView alloc]initWithFrame:imageViewframe];
        show2ImageView.image = img;
        [self.showScrollView addSubview:show2ImageView];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScrollToTop:(UIScrollView *)showScrollView{
}

- (void)scrollViewDidScroll:(UIScrollView *)showScrollView{
    //set pageControl method
    //設置pagewidth的值
    CGFloat pageWidth = 320;
    //當user滑行view超過1/2時，判定為換頁，個案的frame(160,288,320,576)，其contenOffset.x值為160，floor值為0，
    //＋1後，其int page值為1，表示show page 1
    int page = floor((self.showScrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    self.showPageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)showScrollView{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)showScrollView{
}

//tell delegate，scrollview已結束運作，減速移動
- (void)scrollViewDidEndDecelerating:(UIScrollView *)showScrollView{
}

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
