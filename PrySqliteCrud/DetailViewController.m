//
//  DetailViewController.m
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import "DetailViewController.h"
#import "Movie.h"

@interface DetailViewController ()
//- (void)configureView;
@end

@implementation DetailViewController
//@synthesize theMovie = _theMovie;
#pragma mark - Managing the detail item

/*
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
 */


/*
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
 */


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    
    // Configuramos el boton de Guardar la actualizacion
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateMovie:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Cargamos los datos iniciales para ver los datos cargados
    [self setLabelsForMovie];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark User Methods

-(void) setLabelsForMovie
{
    //  Set the labels to the values passed of the passed customer object
    
    _txtId.text=[NSString stringWithFormat:@"%i", self.theMovie.intMovieId];
    _txtTitulo.text=self.theMovie.strTitle;
    _txtYear.text=[NSString stringWithFormat:@"%i", self.theMovie.intYear];
    _txtRating.text=self.theMovie.strRating;
    _txtLength.text=self.theMovie.strLength;
            
}

-(void) updateMovie:(id)sender
{
    //  Create an instance of DBServer class.
    DatabaseController *dbController = [[DatabaseController alloc] init];
    
    [dbController updateMovie:[_txtId.text intValue]
                        Title:_txtTitulo.text
                         Year:[_txtYear.text intValue]
                       Rating:_txtRating.text
                       Length:_txtLength.text];
    
    //  Release the dbAccess object to free its memory
    dbController=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    /*
    // Recomendado Aqui este codigo por temas de Usabilidad
    //  Create an instance of DBServer class.
    DatabaseController *dbController = [[DatabaseController alloc] init];
    
    [dbController updateMovie:[_txtId.text intValue]
                        Title:_txtTitulo.text
                         Year:[_txtYear.text intValue]
                       Rating:_txtRating.text
                       Length:_txtLength.text];
    
    //  Release the dbAccess object to free its memory
    dbController=nil;
    */
    
}








@end
