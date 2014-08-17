
#Abbie assignment1


##為什麼
###xib
`DORootViewController.xib`

###interface



###implementation
`self.showScrollView.contentSize = CGSizeMake(1000, 400);`

`//以dic從URL接資料，所取得的是第二層每個dic的資料
    self.responseDic = [self getResultsDic:URL];
    //因第一層為array形態，故要先創立一個array形態變數先取得第一層資料（livebricks)
    NSArray *responseArray = [self.responseDic objectForKey:@"livebricks"];`
    
`#pragma mark - UIScrollViewDelegate`
