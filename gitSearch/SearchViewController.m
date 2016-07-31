//
//  ViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize txtSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    txtSearch.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished:) name:@"SearchFinishedWithResults" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished:) name:@"SearchFinishedWithNoResults" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeSearch:(id)sender{
    
    
}

-(void) loaderHidden:(BOOL)hidden{
    if (hidden) {
        [loaderView removeFromSuperview];
        return;
    }
    loaderView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 50, 100, 100)];
    loaderView.layer.cornerRadius = 15;
    loaderView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(25, 25, 50, 50);
    [spinner startAnimating];
    [loaderView addSubview:spinner];
    [self.view addSubview:loaderView];
}

-(void) searchFinished:(NSNotification *) notification{
    [self loaderHidden:YES];

    
}

@end
