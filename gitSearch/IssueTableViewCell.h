//
//  IssueTableViewCell.h
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblByUser;
@property (weak, nonatomic) IBOutlet UIButton *btnImg;
@end
