//
//  MSSegmentedControl.m
//  EShareMall
//
//  Created by SongMin on 2019/11/20.
//  Copyright © 2019 lovsoft. All rights reserved.
//

#import "MSSegmentedControl.h"
#import "Masonry.h"

@interface MSSegmentedControl (){
    NSArray *_titlesArray;//标题数组
}

@property (nonatomic, assign)NSInteger radius;//圆角半径

@property (nonatomic, assign)NSInteger btnRadius;//按钮圆角半径

@property (nonatomic, strong)UIColor *segmentedControlbgColor;//segmentedControl的背景颜色

@property (nonatomic, strong)UIColor *borderColor;//segmentedControl的描边颜色

@property (nonatomic, assign)CGFloat borderWidth;//segmentedControl的描边大小

@property (nonatomic, strong)UIColor *selectedTitleColor;//选中的标题颜色

@property (nonatomic, strong)UIColor *normalTitleColor;//未选中的标题颜色

@property (nonatomic, strong)UIColor *selectedBtnBackgroundColor;//选中按钮背景颜色

@property (nonatomic, strong)UIColor *normalBtnBackgroundColor;//未选中按钮背景颜色

@end


@implementation MSSegmentedControl


+(instancetype)creatSegmentedControlWithTitle:(NSArray *)titleArs withRadius:(NSInteger)radius withBtnRadius:(NSInteger)btnRadius withBackgroundColor:(UIColor *)backgroundColor withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNormalTitleColor:(UIColor *)normalTitleColor withSelectedTitleColor:(UIColor *)selectedTitleColor withNormalBtnBackgroundColor:(UIColor *)normalBtnBackgroundColor withSelectedBtnBackgroundColor:(UIColor *)selectedBtnBackgroundColor{
    MSSegmentedControl *segmented = [[MSSegmentedControl alloc]init];
    segmented.radius = radius;
    segmented.segmentedControlbgColor = backgroundColor;
    segmented.borderColor = borderColor;
    segmented.borderWidth = borderWidth;
    segmented.btnRadius = btnRadius;
    segmented.normalTitleColor = normalTitleColor;
    segmented.selectedTitleColor = selectedTitleColor;
    segmented.normalBtnBackgroundColor = normalBtnBackgroundColor;
    segmented.selectedBtnBackgroundColor = selectedBtnBackgroundColor;
    [segmented initSetsWithTitleArs:titleArs];
    return segmented;
}



- (void)initSetsWithTitleArs:(NSArray *)titles{
    self.backgroundColor = self.segmentedControlbgColor;
    self.layer.cornerRadius = self.radius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = 1;
    _titlesArray = titles;
    [self creatBtnWithTitles:_titlesArray];
}

- (void)creatBtnWithTitles:(NSArray *)titles{
    NSInteger count = titles.count;
    for (int index = 0; index < titles.count ; index++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setTitle:titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[self imageWithColor:self.normalBtnBackgroundColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:self.selectedBtnBackgroundColor] forState:UIControlStateSelected];
        
        [btn addTarget:self
                action:@selector(btnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = index + 660;
        [self addSubview:btn];
        if (index == 0) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
            make.width.equalTo(self).dividedBy(count);
            [self isFirstByIndex:index]? make.leading.equalTo(self.mas_leading):make.leading.equalTo([self returnOneBtn:index].mas_trailing).offset(1);
        }];
        btn.layer.cornerRadius = self.btnRadius;
        btn.layer.masksToBounds = YES;
    }
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  判段是否是第一个button 如果是第一个那么其左边是和 self 的左边相等的 如果不是第一个那么其左边是和上一个 button 的右边相等的(也可以有间距 根据需求)
 button的宽度是根据 self 的宽 除以数组的长度 这样就等分
 *
 */

- (BOOL)isFirstByIndex:(NSInteger)index{
    if (index == 0) {
        return YES;
    }
    return NO;
}

/**
 *  取出前一个btn
 *
 */
- (UIButton *)returnOneBtn:(NSInteger)index{
    NSInteger last = index + 660 - 1;
    UIButton *btn = [self viewWithTag:last];
    return btn;
}

- (NSArray *)tagsArray{
    NSMutableArray *muA = [NSMutableArray arrayWithCapacity:_titlesArray.count];
    for (NSInteger index = 0; index < _titlesArray.count; index ++) {
        NSInteger tag = index + 660;
        [muA addObject:@(tag)];
    }
    return muA.copy;
}


- (void)btnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag;
    btn.selected = YES;
    for (NSNumber *nub in [self tagsArray]) {
        if (tag != nub.integerValue) {
            UIButton *btn = [self viewWithTag:nub.integerValue];
            btn.selected = NO;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectSegmentWithIndex:)]) {
        [_delegate didSelectSegmentWithIndex:tag - 660];
    }
}


- (void)updateSelectedIndexToFirst{
    UIButton *btn = [self viewWithTag:660];
    [self btnClicked:btn];
}

- (void)updateSelectedWithIndex:(NSInteger)index{
    UIButton *btn = [self viewWithTag:index + 660];
    [self btnClicked:btn];
}

@end
