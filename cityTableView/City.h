//
//  City.h
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface City : NSObject

@property NSString * name;
@property NSString * state;
@property UIImage * cityImage;

-(instancetype)initWithName:(NSString *)name aState:(NSString *)state anImage:(UIImage * )image;

@end
