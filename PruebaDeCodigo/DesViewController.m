//
//  DesViewController.m
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 31/7/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import "DesViewController.h"

@interface DesViewController ()

@end

@implementation DesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 //   self.title = _titulo;
    
    self.textView.text = self.temporalDes;
    self.label.text = self.titulo;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
