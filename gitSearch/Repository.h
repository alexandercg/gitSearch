//
//  Repository.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *repoDescription;
@property (nonatomic, retain) NSString *repoURL;
@property int starCount;
@property int issuesCount;


- (id)initWithFullName:(NSString*)name
           description:(NSString*)description
                   url:(NSString*)url
                 stars:(int)stars
                issues:(int)issues;

@end
