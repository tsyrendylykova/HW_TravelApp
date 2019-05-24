//
//  TLAMuseumCollectionViewCell.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 26/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface TLAMuseumCollectionViewCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *descriptionTrip;

@end

NS_ASSUME_NONNULL_END
