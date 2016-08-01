//
//  DetailTableViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "DetailTableViewController.h"
#import "GitFetcher.h"
#import "IssueTableViewCell.h"
#import "RepoIssues.h"
#import "GeneralTableViewCell.h"
#import "ContribuitorTableViewCell.h"
@import SafariServices;

@implementation DetailTableViewController

@synthesize repoSelected;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:repoSelected.fullName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished:) name:@"SearchFinishedWithIssues" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished:) name:@"RequestFinishedWithError" object:nil];
    [[[GitFetcher sharedInstance] repoIssues] removeAllObjects];
    [[GitFetcher sharedInstance] getIssuesByRepo:repoSelected.fullName];
    
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", repoSelected.repoURL]];
    SFSafariViewController *vc = [[SFSafariViewController alloc]initWithURL:url entersReaderIfAvailable:NO];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void) searchFinished:(NSNotification *) notification{
    if ([[notification name] isEqualToString:@"SearchFinishedWithError"]){
        [self showAlertWithTitle:@"Warning" message:@"Please verify your internet connection or try it later."];
        return;
    }
    [self.tableView reloadData];
}

-(void) showAlertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}

// MARK: - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int cells = 0;
    switch (section) {
        case 0:
            cells = 1;
            break;
        case 1:
            cells = (int)[[[GitFetcher sharedInstance] repoIssues] count];
            break;
        case 2:
            cells = (int)[[[GitFetcher sharedInstance] repoContribuitors] count];
            break;
    }
    return cells;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GeneralTableViewCell* cell = (GeneralTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"generalInfoCell"];
        
        //SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GeneralInfoCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];

        }
        [cell.btnUsername setTitle: [NSString stringWithFormat:@"By: @%@ ", repoSelected.nameUser]
                     forState: UIControlStateNormal];
        [cell.btnUsername addTarget:self action:@selector(goToProfile:) forControlEvents:UIControlEventTouchUpInside];
        cell.textViewDescription.text = repoSelected.repoDescription;
        [cell.btnURL setTitle:[NSString stringWithFormat:@"%@", repoSelected.repoURL] forState: UIControlStateNormal];
        [cell.btnURL addTarget:self action:@selector(goTuURL:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnURL.hidden = [self verifyTextField:[NSString stringWithFormat:@"%@", repoSelected.repoURL]];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MM/yyyy"];
        [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        cell.lblUpdatedDate.text = [format stringFromDate:repoSelected.updatedDate];
        return cell;
    }
    if (indexPath.section == 1) {
        IssueTableViewCell* cell = (IssueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"issueCell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IssueCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        RepoIssues *item = [[[GitFetcher sharedInstance] repoIssues] objectAtIndex:indexPath.row];
        cell.lblTitle.text = item.issueTitle;
        cell.lblByUser.text = [NSString stringWithFormat:@"#%d Created by %@", item.number, item.createdBy];
        cell.lblComments.text = [NSString stringWithFormat:@"%d Comments", item.coments];
        return cell;
    }
    if (indexPath.section == 2) {
        UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"contribuitorsCell"];
        return cell;
    }
    return nil;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"";
    switch (section) {
        case 0:
            header = @"";
            break;
        case 1:
            header = @"Latest Issues";
            break;
        case 2:
            header = @"Top Contribuitors";
            break;
    }
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int height = 0;
    switch (indexPath.section) {
        case 0:
            height = 140;
            break;
        case 1:
            height = 55;
            break;
        case 2:
            height = 55;
            break;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
