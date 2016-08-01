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

@property (nonatomic, retain) NSMutableArray *repoIssues;
@property (nonatomic, retain) NSMutableArray *repoContributors;

-(id) init;
+(id)sharedInstance;


-(void) searchRepoBy:(NSString*)language andPage:(int)page;

-(void) getIssuesByRepo:(NSString*)repo;

-(void) getContributorsByRepo:(NSString*)repo;



@end
