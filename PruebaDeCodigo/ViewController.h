//
//  ViewController.h
//  PruebaDeCodigo
//
//  Created by Carlos jimenez on 29/07/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabla;


@end

