//
//  BaseBarButtonItem.m
//  Pods
//
//  Created by zhuayi on 8/21/15.
//
//

#import "ZBaseBarButtonItem.h"

@implementation ZBaseBarButtonItem


- (void)setSelected:(BOOL)selected {
    _selected = selected;
}

- (void)setImage:(UIImage *)image {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
    self.customView = button;
}

@end
