//
//  MasterViewController.m
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "NuevoViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self loadMovieObject];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self loadMovieObject];
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    /*
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    */
    NuevoViewController *newCustomerView = [[NuevoViewController alloc] initWithNibName:@"NuevoViewController" bundle:nil];
    
    //  Set the title of the detail page
    [newCustomerView setTitle:@"New Movie"];
    [self.navigationController pushViewController:newCustomerView animated:YES];
    
    newCustomerView=nil;
    
    
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return _arrayMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "Cell"
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = _objects[indexPath.row];
    //cell.textLabel.text = [object description];
    Movie *movie = [_arrayMovies objectAtIndex:[indexPath row]];
    cell.textLabel.text = movie.strTitle;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[_objects removeObjectAtIndex:indexPath.row];
        // Eliminar aqui desde el Array
        DatabaseController *dbController = [[DatabaseController alloc] init];
        Movie *theMovie = [_arrayMovies objectAtIndex:[indexPath row]];
        [dbController deleteMovie:theMovie.intMovieId];
        
        [_arrayMovies removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //"showDetail"
    if ([[segue identifier] isEqualToString:@"segueDetalle"]) {
        /*
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        */
        DetailViewController * detalle = [segue destinationViewController];
        Movie *movie = [_arrayMovies objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detalle.theMovie = movie;
    }
}



#pragma mark User Methods

-(void) loadMovieObject
{
    DatabaseController *dbController = [[DatabaseController alloc] init];
    
    // Crear la tabla si NO existe:
    [dbController createTableMovies];
    
    //  Fire the dbController getAllCustomers method to fill our array
    _arrayMovies = [dbController getAllMovies];
    
    //  Release the dbAccess object to free its memory
    dbController=nil;

}


@end
