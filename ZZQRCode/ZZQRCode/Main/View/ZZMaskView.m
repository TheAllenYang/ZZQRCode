//
//  ZZMaskView.m
//  ZZQRCode
//
//  Created by POPLAR on 2017/6/6.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ZZMaskView.h"

@interface ZZMaskView ()

@property (nonatomic, strong) CALayer *lineLayer;

@property (strong,nonatomic) UIImageView *sideImageView;
@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) UIView *leftView;
@property (strong,nonatomic) UIView *rightView;


@end

@implementation ZZMaskView

+ (instancetype)maskView {
    
    ZZMaskView *maskView = [[ZZMaskView alloc] init];
    
    return maskView;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
    
}

-(void)setupUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    if (!_allAroundColor) {
        _allAroundColor = [UIColor blackColor];
    }
    
    if (!_allAroundAlpha) {
        _allAroundAlpha = 0.4;
    }
    
    if (!_sideImage) {
        _sideImage = [UIImage imageNamed:@"img_test_wide"];
    }
    
    if (!_lineImage) {
        _lineImage = [UIImage imageNamed:@"img_test_wire"];
    }
    
    //扫描区域
    UIImageView *sideImageView = [[UIImageView alloc] init];
    sideImageView.image = _sideImage;
    [self addSubview:sideImageView];
    
    //上
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = _allAroundColor;
    topView.alpha = _allAroundAlpha;
    [self addSubview:topView];
    
    //下
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = _allAroundColor;
    bottomView.alpha = _allAroundAlpha;
    [self addSubview:bottomView];
    
    //左
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = _allAroundColor;
    leftView.alpha = _allAroundAlpha;
    [self addSubview:leftView];
    
    //右
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = _allAroundColor;
    rightView.alpha = _allAroundAlpha;
    [self addSubview:rightView];
    
    //--------布局
    
    if (!_scanSize) {
        _scanSize = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.8;
    }
   
    [sideImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.offset(0);
        make.width.height.offset(_scanSize);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.offset(0);
        make.bottom.equalTo(sideImageView.mas_top).offset(0);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.offset(0);
        make.top.equalTo(sideImageView.mas_bottom).offset(0);
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.bottom.equalTo(bottomView.mas_top).offset(0);
        make.left.offset(0);
        make.right.equalTo(sideImageView.mas_left).offset(0);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.bottom.equalTo(bottomView.mas_top).offset(0);
        make.right.offset(0);
        make.left.equalTo(sideImageView.mas_right).offset(0);
    }];
    
    
    self.lineLayer = [CALayer layer];
    self.lineLayer.contents = (id)_lineImage.CGImage;
    [self.layer addSublayer:self.lineLayer];
    [self repetitionAnimation];
    
    _sideImageView = sideImageView;
    _topView = topView;
    _bottomView = bottomView;
    _leftView = leftView;
    _rightView = rightView;

}

-(void)setScanSize:(CGFloat)scanSize{
    
    _scanSize = scanSize;
    
    [_sideImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.offset(0);
        make.width.height.offset(_scanSize);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.offset(0);
        make.bottom.equalTo(_sideImageView.mas_top).offset(0);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.offset(0);
        make.top.equalTo(_sideImageView.mas_bottom).offset(0);
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_topView.mas_bottom).offset(0);
        make.bottom.equalTo(_bottomView.mas_top).offset(0);
        make.left.offset(0);
        make.right.equalTo(_sideImageView.mas_left).offset(0);
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_topView.mas_bottom).offset(0);
        make.bottom.equalTo(_bottomView.mas_top).offset(0);
        make.right.offset(0);
        make.left.equalTo(_sideImageView.mas_right).offset(0);
    }];
    
    
    
    
    
}

-(void)setSideImage:(UIImage *)sideImage{
    _sideImage = sideImage;
    _sideImageView.image = _sideImage;
}

-(void)setLineImage:(UIImage *)lineImage{
    _lineImage = lineImage;
    _lineLayer.contents = (id)_lineImage.CGImage;
}

-(void)setLineDuration:(CGFloat)lineDuration{
    _lineDuration = lineDuration;
}

-(void)setAllAroundColor:(UIColor *)allAroundColor{
    _allAroundColor = allAroundColor;
    
    _topView.backgroundColor = allAroundColor;
    _bottomView.backgroundColor = allAroundColor;
    _leftView.backgroundColor = allAroundColor;
    _rightView.backgroundColor = allAroundColor;
}

-(void)setAllAroundAlpha:(CGFloat)allAroundAlpha{
    _allAroundAlpha = allAroundAlpha;
    
    _topView.alpha = allAroundAlpha;
    _bottomView.alpha = allAroundAlpha;
    _leftView.alpha = allAroundAlpha;
    _rightView.alpha = allAroundAlpha;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
    self.lineLayer.frame = CGRectMake((self.frame.size.width - _scanSize) / 2, (self.frame.size.height - _scanSize) / 2, _scanSize, 2);
}

- (void)stopAnimation
{
    [self.lineLayer removeAnimationForKey:@"translationY"];
}

- (void)repetitionAnimation
{
    if (!_lineDuration) {
        _lineDuration = 2;
    }
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    basic.fromValue = @(0);
    basic.toValue = @(_scanSize);
    basic.duration = _lineDuration;
    basic.repeatCount = NSIntegerMax;
    [self.lineLayer addAnimation:basic forKey:@"translationY"];
}




@end
