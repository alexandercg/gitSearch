//
//  DetailTableViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "DetailTableViewController.h"
@import SafariServices;

@implementation DetailTableViewController

@synthesize repoSelected, btnUsername, textViewDescription, lblUpdatedDate, btnURL;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:repoSelected.fullName];
    [btnUsername setTitle: [NSString stringWithFormat:@"By: @%@ ", repoSelected.nameUser]
                 forState: UIControlStateNormal];
    
    textViewDescription.text = repoSelected.repoDescription;
    
    [btnURL setTitle:[NSString stringWithFormat:@"%@", repoSelected.repoURL] forState: UIControlStateNormal];
    btnURL.hidden = [self verifyTextField:[NSString stringWithFormat:@"%@", repoSelected.repoURL]];
    
}

-(BOOL) verifyTextField:(NSString *) text{
    if ([text isEqualToString:@"<null>"]) {
        return YES;
    }
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [text length] == 0;
}

- (IBAction)goToProfile:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/%@", repoSelected.nameUser]];
    SFSafariViewController *vc = [[SFSafariViewController alloc]initWithURL:url entersReaderIfAvailable:NO];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)goTuURL:(id)sender {
}
@end
