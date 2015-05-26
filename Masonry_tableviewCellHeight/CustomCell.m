//
//  CustomCell.m
//  Masonry_tableviewCellHeight
//
//  Created by wendongsheng on 15/5/26.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()
{
    BOOL _didSetupConstraints;
}

@property (nonatomic, strong) UILabel *label;

@end

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViews];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setupViews{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor blackColor];
        _label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_label];
    }
}

- (void)configLabelText:(NSString *)text{
    _label.text = text;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    _label.preferredMaxLayoutWidth = CGRectGetWidth(_label.frame);
}

- (void)updateConstraints{
    if (!_didSetupConstraints) {
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-5);
        }];
        
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
