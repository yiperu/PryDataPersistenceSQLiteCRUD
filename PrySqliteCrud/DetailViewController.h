//
//  DetailViewController.h
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "Movie.h"
#import "DatabaseController.h"
@class Movie;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

//------

@property (strong, nonatomic) IBOutlet UITextField *txtId;
@property (strong, nonatomic) IBOutlet UITextField *txtTitulo;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic) IBOutlet UITextField *txtRating;
@property (strong, nonatomic) IBOutlet UITextField *txtLength;

@property (nonatomic, strong) Movie *theMovie;

-(void)setLabelsForMovie;
-(void)updateMovie:(id)sender;



@end
