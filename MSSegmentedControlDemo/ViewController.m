//
//  ViewController.m
//  MSSegmentControl
//
//  Created by SongMin on 2019/11/25.
//  Copyright © 2019 lovsoft. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MSSegmentedControl.h"

// 16进制设置颜色
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<MSSegmentedControlDelegate>

@property (nonatomic, strong)MSSegmentedControl *scontr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorRGB(0x438BED);
    
    [self setControl];
    
    //设置选中标签index
    [self.scontr updateSelectedWithIndex:1];
}

- (void)setControl{
    UIColor *backgroundColor = ColorRGB(0x2168C8);
    UIColor *borderColor = ColorRGB(0x2168C8);
    UIColor *titleColor = [UIColor whiteColor];
    UIColor *normalColor = ColorRGB(0x2168C8);
    UIColor *selectedColor = ColorRGB(0x438BED);
    
    self.scontr = [MSSegmentedControl creatSegmentedControlWithTitle:@[@"普通订单",@"会员订单"] withRadius:4 withBtnRadius:4 withBackgroundColor:backgroundColor withBorderColor:borderColor withBorderWidth:1.f withNormalTitleColor:titleColor withSelectedTitleColor:titleColor withNormalBtnBackgroundColor:normalColor withSelectedBtnBackgroundColor:selectedColor];
    _scontr.delegate = self;
    [self.view addSubview:_scontr];
    [_scontr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.bounds.size.width * 0.5);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.view.mas_top).offset(80);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - CustomSegmentedControlDelegate

- (void)didSelectSegmentWithIndex:(NSInteger)index{
    NSLog(@"--->%ld",index);
}




@end
