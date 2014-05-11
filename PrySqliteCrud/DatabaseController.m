//
//  DatabaseController.m
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import "DatabaseController.h"

#import "Movie.h"

@implementation DatabaseController


sqlite3 *sqlDatabase;

-(id) init
{   //  Call super init to invoke superclass initiation code
    if ((self = [super init]))
    {   //  set the reference to the database
        dbName = @"movies.sqlite3";
        [self initializeDatabase];
    }
    return self;
}

- (void) initializeDatabase
{
    [self CopyDbToDocumentsFolder];
    
    //Get list of directories in Document path
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Define new path for database
    NSString *path = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:dbName];
    
    // Get the database from the application bundle.
    NSLog(@"%@", path);
    // Open the database.
    if (sqlite3_open([path UTF8String], &sqlDatabase) == SQLITE_OK)
    {
        NSLog(@"Opening Database");
    }
    else
    {   // Call close to properly clean up
        sqlite3_close(sqlDatabase);
        NSAssert1(0, @"Failed to open database: '%s'.",
                  sqlite3_errmsg(sqlDatabase));
    }
}

-(void) CopyDbToDocumentsFolder
{
    NSError *err=nil;
    
    _fileMgr = [NSFileManager defaultManager];
    
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    // lets only copy the db if it does not exist
    if (![_fileMgr fileExistsAtPath:copydbpath])
    {
        if(![_fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
        {
            UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:_title message:@"Unable to copy database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [tellErr show];
        }
    }
}

-(NSString *) GetDocumentDirectory
{
    _fileMgr = [NSFileManager defaultManager];
    _homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    return _homeDir;
}

-(void) closeDatabase
{
    // Close the database.
    if (sqlite3_close(sqlDatabase) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database: '%s'.",
                  sqlite3_errmsg(sqlDatabase));
    }
}



// Desde aqui trabaja con la Tabla Movie

// ------------------------------------
-(void)createTableMovies {
    /*
     NSString *docsDir;
     NSArray *dirPaths;
     
     // Get the documents directory
     dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     docsDir = [dirPaths objectAtIndex:0];
     
     // Build the path to the database file
     databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"employees.db"]];
     
     NSFileManager *filemgr = [NSFileManager defaultManager];
     
     //the file will not be there when we load the application for the first time
     //so this will create the database table
     if ([filemgr fileExistsAtPath: databasePath ] == NO)
     {
     const char *dbpath = [databasePath UTF8String];
     if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
     {
     char *errMsg;
     NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS EMPLOYEES (";
     sql_stmt = [sql_stmt stringByAppendingString:@"id INTEGER PRIMARY KEY AUTOINCREMENT, "];
     sql_stmt = [sql_stmt stringByAppendingString:@"name TEXT, "];
     sql_stmt = [sql_stmt stringByAppendingString:@"department TEXT, "];
     sql_stmt = [sql_stmt stringByAppendingString:@"age TEXT)"];
     
     if (sqlite3_exec(mySqliteDB, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
     {
     NSLog(@"Failed to create table");
     }
     else
     {
     NSLog(@"Employees table created successfully");
     }
     
     sqlite3_close(mySqliteDB);
     
     } else {
     NSLog(@"Failed to open/create database");
     }
     }
     */
    
    //-----------------------------------------------
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"Ah Ocurrido un Error (createTableMovies).");
        return;
    }
    else
    {
        
        
        char *errMsg;
        NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS movies (";
        sql_stmt = [sql_stmt stringByAppendingString:@"id INTEGER PRIMARY KEY AUTOINCREMENT, "];
        sql_stmt = [sql_stmt stringByAppendingString:@"title TEXT, "];
        sql_stmt = [sql_stmt stringByAppendingString:@"year INTEGER, "];
        sql_stmt = [sql_stmt stringByAppendingString:@"rating TEXT, "];
        sql_stmt = [sql_stmt stringByAppendingString:@"length TEXT)"];
        NSLog(@"Linea %@ (createTableMovies).",sql_stmt);
        
        if (sqlite3_exec(sqlDatabase, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Falla para crear la Tabla movies (createTableMovies)");
        }
        else
        {
            NSLog(@"movies table created successfully (createTableMovies)");
        }
        
        sqlite3_close(sqlDatabase);
        
        
    }
    
    
}




-(NSMutableArray*) getAllMovies
{
    NSMutableArray *arrayMovies = [[NSMutableArray alloc] init];
    
    const char *mySql = "SELECT id, title, year, rating, length FROM movies";
    const int movieId = 0;
    const int movieTitle = 1;
    const int movieYear = 2;
    const int movieRating = 3;
    const int movieLength = 4;
    
//------------
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        //return;
    }
    else
    {
        //  Declare the SQLite statement object that will hold our result set
        sqlite3_stmt *myStatement;
        
        int sqlResult = sqlite3_prepare_v2(sqlDatabase, mySql, -1, &myStatement, NULL);
        if ( sqlResult== SQLITE_OK)
        {
            while (sqlite3_step(myStatement) == SQLITE_ROW)
            {
                char *name = (char *)sqlite3_column_text(myStatement, movieTitle);
                char *rating = (char *)sqlite3_column_text(myStatement, movieRating);
                char *length = (char *)sqlite3_column_text(myStatement, movieLength);
                
                Movie *movies = [[Movie alloc]
                                 initWithMovieId:sqlite3_column_int(myStatement, movieId)
                                 WithTitle:(name) ? [NSString stringWithUTF8String:name] : @""
                                 WithYear:sqlite3_column_double(myStatement, movieYear)
                                 WithRating:(rating) ? [NSString stringWithUTF8String:rating] : @""
                                 WithLength:(length) ? [NSString stringWithUTF8String:length] : @""];
                [arrayMovies addObject:movies];
                movies = nil;
            }
            sqlite3_finalize(myStatement);
        }
        else {
            NSLog(@"Problemas con la base de Datos (getAllMovies):");
            NSLog(@"%d",sqlResult);
        }
    }
    

    return arrayMovies;
}








-(void) insertMovie:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Movies (title, year, rating, length) VALUES ('%@',%i, '%@', '%@')", fldTitle, fldYear, fldRating, fldLength];
        
        const char *sql = [insertSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}

-(void) updateMovie:(int) fldMovieId
              Title:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *updateSQL = [NSString stringWithFormat:
                               @"UPDATE movies SET Title='%@', year=%i, rating='%@', length='%@' WHERE id=%i", fldTitle, fldYear, fldRating, fldLength, fldMovieId];
        
        const char *sql = [updateSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}

-(void) deleteMovie:(int) fldMovieId
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM movies WHERE id = '%i'", fldMovieId];
        const char *sql = [deleteSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}




@end
