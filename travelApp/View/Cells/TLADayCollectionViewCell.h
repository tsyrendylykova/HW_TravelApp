//
//  TLADayCollectionViewCell.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 08/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface TLADayCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLabel;

- (void)selectedCell:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
