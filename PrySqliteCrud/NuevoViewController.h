//
//  NuevoViewController.h
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DatabaseController.h"

@interface NuevoViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *txtId;
@property (strong, nonatomic) IBOutlet UITextField *txtTitulo;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic) IBOutlet UITextField *txtRating;
@property (strong, nonatomic) IBOutlet UITextField *txtLength;


-(void)saveMovie:(id)sender;

//----  IBOutlet:

- (IBAction)btnCancelar:(id)sender;
- (IBAction)btnGuardar:(id)sender;

@end
