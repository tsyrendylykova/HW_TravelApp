//
//  TLADetailMuseumCollectionViewCell.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLADetailMuseumCollectionViewCell.h"


@implementation TLADetailMuseumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _coverImageView = imageView;
        _coverImageView.layer.cornerRadius = CGRectGetHeight(frame) / 2;
        _coverImageView.layer.masksToBounds = @YES;
        [self.contentView addSubview:_coverImageView];
        
    }
    return self;
}

@end
