//
//  DetailTableViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "DetailTableViewController.h"

@implementation DetailTableViewController

@synthesize repoSelected;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:repoSelected.fullName];
    
}

@end
