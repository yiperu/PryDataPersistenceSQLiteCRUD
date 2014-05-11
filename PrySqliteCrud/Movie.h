//
//  Movie.h
//  PrySqliteCrud
//
//  Created by Henry AT on 5/10/14.
//  Copyright (c) 2014 Henry AT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(nonatomic) int      intMovieId;
@property(nonatomic, strong)  NSString *strTitle;
@property(nonatomic) int      intYear;
@property(nonatomic, strong)  NSString *strRating;
@property(nonatomic, strong)  NSString *strLength;

-(id)  initWithMovieId: (int) pMovieId
             WithTitle:(NSString *) pTitle
              WithYear: (int) pYear
            WithRating: (NSString *) pRating
            WithLength: (NSString *) pLength;




@end
