//
//  DetalleViewController.h
//  PruebaDeCodigo
//
//  Created by Carlos jimenez on 29/07/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "modelo.h"


@interface DetalleViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (weak, nonatomic) NSString *tempTitle;
@property (strong, nonatomic) NSString *tempDescr;
@property (weak, nonatomic) NSString *tempCoord;
@property (weak, nonatomic) NSString *tempId;
@property (weak, nonatomic) NSString *tempTrans;
@property (weak, nonatomic) NSString *tempDirec;
@property (weak, nonatomic) NSString *tempMail;
@property (nonatomic, strong) IBOutlet UIButton *button;


@property (weak, nonatomic) NSArray *data;

@property (weak, nonatomic) IBOutlet UILabel *detalleLugar;
@property (weak, nonatomic) IBOutlet UILabel *detalleEmail;
@property (weak, nonatomic) IBOutlet UILabel *detalleDirec;
@property (weak, nonatomic) IBOutlet UILabel *detalleTrans;

@property (weak, nonatomic) NSString *lati;
@property (weak, nonatomic) NSString *longi;
- (IBAction)menu:(id)sender;


@property (weak, nonatomic) modelo *model;

-(id)initWithModel: (modelo *)aModel;



@end
