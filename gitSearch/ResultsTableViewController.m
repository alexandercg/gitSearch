//
//  ResultsTableViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "ResultsTableViewController.h"

@implementation ResultsTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
}

- (IBAction)backToSearch:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
