# MSSegmentedControl
封装可自定义UISegmentedControl<br/>
![image](https://github.com/sunmean/MSSegmentedControl/blob/master/record201911125001.gif)

---
简要介绍
==============
项目中封装了七种自定义的方法弹框，可以根据实际需要选择便捷的方法调用。七种方法中，越往后的方法，可自定义的属性越多，当然使用设置也会越麻烦。示例可以查看上面的动图。<br/>

使用方法
==============

### 1.调用头文件
```objc
#import "MSSegmentedControl.h"
#import "Masonry.h"
```

### 2.导入方法文件夹
导入MSSegmentedControlDemo项目中的MSSegmentedControl的文件夹和Masonry文件夹

### 3.方法调用
```objc
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

```

### 4.方法参数说明
```objc

/**
*
*  @param titleArs                     标题数组
*  @param radius                       整体圆角半径
*  @param btnRadius                    单个标签圆角半径
*  @param backgroundColor              整体背景颜色
*  @param borderColor                  整体描边颜色
*  @param borderWidth                  整体描边宽度
*  @param normalTitleColor             未选中的标签文字颜色
*  @param selectedTitleColor           选中的标签文字颜色
*  @param normalBtnBackgroundColor     未选中的标签背景颜色
*  @param selectedBtnBackgroundColor   选中的标签背景颜色
*
*/

+(instancetype)creatSegmentedControlWithTitle:(NSArray *)titleArs withRadius:(NSInteger)radius withBtnRadius:(NSInteger)btnRadius withBackgroundColor:(UIColor *)backgroundColor withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNormalTitleColor:(UIColor *)normalTitleColor withSelectedTitleColor:(UIColor *)selectedTitleColor withNormalBtnBackgroundColor:(UIColor *)normalBtnBackgroundColor withSelectedBtnBackgroundColor:(UIColor *)selectedBtnBackgroundColor;

/**
*  有些情况的特殊需要 比如 初始化的时候默认 第二个是选中状态
*/
- (void)updateSelectedWithIndex:(NSInteger)index;

```

### 5.温馨提示
==============
如果由于旧版本Xcode导致无法运行，请在Xcode顶部菜单栏上面选择“File”->"Workspace Settings..."->"Build System"->"Legacy Build System"。设置一下就可以兼容旧版本Xcode生成的项目引起的报错。


### 6.许可证
==============
MSShowBoxAlert 使用 MIT 许可证，详情见 LICENSE 文件。
