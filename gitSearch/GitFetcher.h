//
//  GitFetcher.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitFetcher : NSObject{
    GitFetcher* instance;
}

@property (nonatomic, retain) NSString *languageSearch;
@property (nonatomic, retain) NSMutableArray *itemsFound;

+(id)sharedInstance;


-(void) searchRepoBy:(NSString*)language andPage:(int)page;



@end
