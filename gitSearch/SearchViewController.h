//
//  ViewController.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITextFieldDelegate>{
    UIView* loaderView;
}
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)makeSearch:(id)sender;

@end

