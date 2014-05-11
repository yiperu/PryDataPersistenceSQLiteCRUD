//
//  NuevoViewController.m
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import "NuevoViewController.h"

#import "DatabaseController.h"

@interface NuevoViewController ()

@end

@implementation NuevoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveMovie:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

-(void)saveMovie:(id)sender
{
    

    //  Create an instance of DBServer class.
    DatabaseController *myDB = [[DatabaseController alloc] init];
    
    [myDB insertMovie:_txtTitulo.text
                 Year:[_txtYear.text integerValue]
               Rating:_txtRating.text
               Length:_txtLength.text];
    
    //  Release the dbAccess object to free its memory
    myDB=nil;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCancelar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnGuardar:(id)sender {

    if ([_txtTitulo.text length]>3) {
        //  Create an instance of DBServer class.
        DatabaseController *myDB = [[DatabaseController alloc] init];
        
        [myDB insertMovie:_txtTitulo.text
                     Year:[_txtYear.text integerValue]
                   Rating:_txtRating.text
                   Length:_txtLength.text];
        
        //  Release the dbAccess object to free its memory
        myDB=nil;
        
            [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Titulo" message:@"Debe ingresar nombre del cliente" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alerta show];
    }
    
    
    
    
    
    
}






















@end
