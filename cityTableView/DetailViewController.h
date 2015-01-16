//
//  DetailViewController.h
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol DetailViewDelegate <NSObject>

-(void)onSetTitlePressed:(NSString *)title;

@end

@interface DetailViewController : UIViewController

@property City *selectedCity;
@property (weak, nonatomic) id<DetailViewDelegate> delegate;


@end
