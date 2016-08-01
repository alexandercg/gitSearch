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

@property (weak, nonatomic) IBOutlet UIImageView *imgDetailView;
@property (weak, nonatomic) IBOutlet UIButton *btnUsername;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdatedDate;
@property (weak, nonatomic) IBOutlet UIButton *btnURL;

- (IBAction)goToProfile:(id)sender;
- (IBAction)goTuURL:(id)sender;

@end
