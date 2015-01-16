//
//  City.m
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "City.h"

@implementation City


//Overriding init
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        return[self initWithName:nil aState:nil anImage:nil];
    }
    return self;
}

//designated initializer
-(instancetype)initWithName:(NSString *)name aState:(NSString *)state anImage:(UIImage * )image
{

    self = [super init];
    if (self)
    {
        self.name = name;
        self.state = state;
        self.cityImage = image;
    }
    return self;

}


@end
