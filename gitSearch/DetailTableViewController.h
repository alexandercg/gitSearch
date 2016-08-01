//
//  DetailTableViewController.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repository.h"

@interface DetailTableViewController : UITableViewController

@property (nonatomic) Repository *repoSelected;



- (IBAction)goToProfile:(id)sender;
- (IBAction)goTuURL:(id)sender;

@end
