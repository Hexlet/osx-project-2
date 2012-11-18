//
//  IVMasterViewControllerCell.h
//  IrregularVerbs
//
//  Created by Andrew on 14.11.12.
//  Copyright (c) 2012 AndrewVanyurin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVMasterViewControllerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkSign;

@end
