//
//  GitFetcher.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "GitFetcher.h"
#import "Repository.h"

#define ApiURL  @"https://api.github.com"

@implementation GitFetcher

@synthesize languageSearch, itemsFound;

+(id)sharedInstance {
    static GitFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) searchRepoBy:(NSString*)language andPage:(int)page{
    instance = [GitFetcher sharedInstance];
    instance.languageSearch = language;
    if(page == 1){
        [instance.itemsFound removeAllObjects];
    }
    language = [language stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"%@/search/repositories?q=language:%@&&sort=stars&order=desc&per_page=100&page=%d", ApiURL, language, page]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length > 0 && error == nil) {
            NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
            NSString* status = [headers valueForKey:@"Status"];
            
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* items = [results mutableArrayValueForKey:@"items"];
            [self manageResultItems:items];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([status isEqualToString:@"200 OK"] && [items count] > 0) {
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"SearchFinishedWithResults"
                     object:self];
                }else{
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"SearchFinishedWithNoResults"
                     object:self];
                }
            });
            
            
        }else{
            NSLog(@"%@",[error localizedDescription]);
        }
        
        
    }] resume];
}

-(void) manageResultItems:(NSArray*)items{
    if (instance.itemsFound == nil) {
        instance.itemsFound = [[NSMutableArray alloc] init];
    }
    for (NSDictionary* item in items) {
        Repository* repo = [[Repository alloc] initWithFullName:[item valueForKey:@"full_name"]
                                                    description:[item valueForKey:@"description"]
                                                            url:[item valueForKey:@"html_url"]
                                                          stars:[[item valueForKey:@"stargazers_count"] intValue]
                                                         issues:[[item valueForKey:@"open_issues_count"] intValue]];
        [instance.itemsFound addObject:repo];
    }
}

@end
