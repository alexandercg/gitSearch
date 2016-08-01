//
//  RepoContribuitor.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoContributor : NSObject
@property (nonatomic, retain) NSString *username;
@property int contributions;

-(id) initWithUsername:(NSString *)name contributions:(int)number;
@end
