# ZJActionSheet
一个很方便自定义的actionSheet, 已经实现了系统的效果, 不过支持显示图片, 支持自定义, 同时也实现了微信的actionSheet的效果

![actionSheet.gif](http://upload-images.jianshu.io/upload_images/1271831-942eeccfe9762b2c.gif?imageMogr2/auto-orient/strip)


```
  ZJActionSheetItem *item8 = [[ZJActionSheetItem alloc] initWithTitle:@"可以自定义所有item的字体颜色 大小等" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item9 = [[ZJActionSheetItem alloc] initWithTitle:@"可以设置actionSheet居中或者居下显示" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];

    ZJActionSheetView *actionSheet = [[ZJActionSheetView alloc] initWithTitle:@"这是提示title" subtitle:@"这是详细说明文字,字体默认14,可修改subtitleLabel" actionSheetItems:@[item1, item2, item3,item4,item5,item6,item7,item8,item9]];
    // 显示
    [actionSheet show];
```


> 这是我写的<iOS自定义控件剖析>这本书籍中的一个demo, 如果你希望知道具体的实现过程和其他的一些常用效果的实现, 那么你应该能轻易在网上下载到免费的盗版书籍. 

> 当然作为本书的写作者, 还是希望有人能支持正版书籍. 如果你有意购买书籍, 在[这篇文章中](http://www.jianshu.com/p/510500f3aebd), 介绍了书籍中所有的内容和书籍适合阅读的人群, 和一些试读章节, 以及购买链接. 在你准备[购买](http://www.qingdan.us/product/13)之前, 请一定读一读里面的说明. 否则, 如果不适合你阅读, 虽然书籍售价35不是很贵, 但是也是一笔损失.


> 如果你希望联系到我, 可以通过[简书](http://www.jianshu.com/users/fb31a3d1ec30/latest_articles)联系到我
