//
//  ZZMaskView.h
//  ZZQRCode
//
//  Created by POPLAR on 2017/6/6.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZMaskView : UIView

@property (strong,nonatomic) UIButton *lightBtn;
@property (strong,nonatomic) UIButton *imgBtn;
@property (strong,nonatomic) UIButton *createBtn;

+ (instancetype)maskView;
- (void)repetitionAnimation;
@end
