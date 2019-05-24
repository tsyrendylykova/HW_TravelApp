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

@property (nonatomic, strong) UIImageView *coverImageView; /**< image музея */
@property (nonatomic, strong) UILabel *name; /**< Название музея */
@property (nonatomic, strong) UILabel *descriptionTrip; /**< Описание музея */

@end

NS_ASSUME_NONNULL_END
