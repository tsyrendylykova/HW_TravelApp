//
//  DayCollectionViewCell.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 08/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "DayCollectionViewCell.h"

@implementation DayCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareLabel];
    }
    return self;
}

-(void)prepareLabel {
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.contentView.layer.cornerRadius = 25;
    self.contentView.layer.masksToBounds = @YES;
    [self.contentView addSubview:_dateLabel];
}

-(void)selectedCell: (BOOL)selected {
    if (selected) {
        self.dateLabel.backgroundColor = [UIColor blueColor];
        self.dateLabel.textColor = [UIColor whiteColor];
    } else {
        self.dateLabel.backgroundColor = [UIColor whiteColor];
        self.dateLabel.textColor = [UIColor blackColor];
    }
}

@end
