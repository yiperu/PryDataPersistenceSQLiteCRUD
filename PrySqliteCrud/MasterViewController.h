//
//  MasterViewController.h
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"
#import "DatabaseController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController


@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *arrayMovies;

-(void)loadMovieObject;


@end
