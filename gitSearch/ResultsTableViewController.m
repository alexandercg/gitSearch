//
//  ResultsTableViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "GitFetcher.h"
#import "RepoTableViewCell.h"
#import "Repository.h"
#import "DetailTableViewController.h"

@implementation ResultsTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMoreItems) name:@"SearchFinishedWithResults" object:nil];
    
}

- (IBAction)backToSearch:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) loadMoreItems{
    [self.tableView reloadData];
}
// MARK: - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[GitFetcher sharedInstance] itemsFound] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepoTableViewCell* cell = (RepoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"repositoryCell"];
    
    Repository* item = [[[GitFetcher sharedInstance] itemsFound] objectAtIndex:indexPath.row];
    cell.lblName.text = item.fullName;
    cell.lblStars.text = [NSString stringWithFormat:@"%d", item.starCount];
    cell.lblIssues.text = [NSString stringWithFormat:@"%d", item.issuesCount];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showDetailRepo" sender: indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == ([[[GitFetcher sharedInstance] itemsFound] count] - 10)) {
        int page = (int)[[[GitFetcher sharedInstance] itemsFound] count]/100;
        [[GitFetcher sharedInstance] searchRepoBy:[[GitFetcher sharedInstance] languageSearch] andPage:page + 1];
        
    }
}

@end
