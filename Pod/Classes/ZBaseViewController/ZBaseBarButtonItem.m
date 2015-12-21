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

- (UIButton *)button {
    if (_button == nil) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)setImage:(UIImage *)image {
    
    self.button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self.button setImage:image forState:UIControlStateNormal];
    self.customView = self.button;
}

@end
