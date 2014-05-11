//
//  Movie.m
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id)  initWithMovieId: (int) pMovieId
             WithTitle:(NSString *) pTitle
              WithYear: (int) pYear
            WithRating: (NSString *) pRating
            WithLength: (NSString *) pLength
{
    if ((self=[super init]))
    {
        self.intMovieId = pMovieId;
        self.strTitle = pTitle;
        self.intYear = pYear;
        self.strRating = pRating;
        self.strLength = pLength;
        return self;
    }
    else
    {
        return nil;
    }
}



@end
