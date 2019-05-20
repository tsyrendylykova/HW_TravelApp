//
//  MuseumCollectionViewCell.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 26/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MuseumCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MuseumCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        cellView.layer.cornerRadius = 10;
        cellView.layer.masksToBounds = @YES;
        cellView.layer.borderWidth = 3.0;
        cellView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:cellView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) * 0.7)];
        _coverImageView = imageView;
        _coverImageView.layer.cornerRadius = 10;
        _coverImageView.layer.masksToBounds = @YES;
        [self.contentView addSubview:_coverImageView];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(frame) * 0.7, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame) * 0.1)];
        _name.textColor = [UIColor blackColor];
        _name.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        [self.contentView addSubview:_name];
        
        _descriptionTrip = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(frame) * 0.8, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame) * 0.2)];
        _descriptionTrip.textColor = [UIColor blackColor];
        _descriptionTrip.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        [self.contentView addSubview:_descriptionTrip];
        
    }
    return self;
}

@end
