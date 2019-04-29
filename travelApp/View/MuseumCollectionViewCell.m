//
//  MuseumCollectionViewCell.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 26/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MuseumCollectionViewCell.h"

@implementation MuseumCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame) - 10)];
        _coverImageView = imageView;
        _coverImageView.layer.cornerRadius = 10;
        _coverImageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_coverImageView];
    }
    return self;
}

@end
