//
//  ViewController.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "SearchViewController.h"
#import "GitFetcher.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished:) name:@"SearchFinishedWithError" object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void) hideKeyboard{
    [self.view endEditing:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchFinished:(NSNotification *) notification{
    [self loaderHidden:YES];
    if ([[notification name] isEqualToString:@"SearchFinishedWithError"]){
        [self showAlertWithTitle:@"Warning" message:@"Please verify your internet connection or try it later."];
        return;
    }
    if ([[notification name] isEqualToString:@"SearchFinishedWithNoResults"]){
        [self showAlertWithTitle:@"No results" message:@"Sorry there is no results for your search."];
        return;
    }
    txtSearch.text = @"";
    [self performSegueWithIdentifier:@"ShowResults" sender:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self makeSearch:nil];
    return YES;
}

- (IBAction)makeSearch:(id)sender{
    if ([self verifyTextField:txtSearch]) {
        [self showAlertWithTitle:@"Warning" message:@"Please enter a language programming."];
        txtSearch.text = @"";
        [txtSearch becomeFirstResponder];
        return;
    }
    [self.view endEditing:YES];
    [self loaderHidden:NO];
    [[GitFetcher sharedInstance] searchRepoBy:txtSearch.text andPage:1];
    
}

-(BOOL) verifyTextField:(UITextField *) textField{
    NSString* text = textField.text;
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [text length] == 0;
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
@end
