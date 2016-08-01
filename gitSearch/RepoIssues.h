//
//  RepoIsuues.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoIssues : NSObject

@property (nonatomic, retain) NSString *issueTitle;
@property (nonatomic, retain) NSString *createdBy;
@property (nonatomic, retain) NSString *url;
@property int number;
@property int coments;

- (id)initWithTitle:(NSString*)title
                 by:(NSString*)user
                url:(NSString*)issueUrl
             number:(int)issueNumber
            coments:(int)numberComments;

@end
