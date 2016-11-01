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