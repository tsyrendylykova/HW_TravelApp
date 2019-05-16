//
//  MapPoint.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapPoint : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *categoryImage;

-(instancetype)initWithName: (NSString *)name urlImage:(NSString *)urlImage;

@end

NS_ASSUME_NONNULL_END
