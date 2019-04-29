//
//  MuseumCollectionViewCell.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 26/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MuseumCollectionViewCell : UICollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIImageView *coverImageView;

@end

NS_ASSUME_NONNULL_END
