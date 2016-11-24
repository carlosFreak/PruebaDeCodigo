//
//  DesViewController.h
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 31/7/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesViewController : UIViewController

@property (weak, nonatomic) NSString *temporalDes;
@property (weak, nonatomic) NSString *titulo;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
