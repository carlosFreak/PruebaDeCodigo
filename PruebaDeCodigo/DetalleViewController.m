//
//  DetalleViewController.m
//  PruebaDeCodigo
//
//  Created by Carlos jimenez on 29/07/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import "DetalleViewController.h"
#import "MapAnnotation.h"
#import "DesViewController.h"
#import "modelo.h"


@interface DetalleViewController ()

@end

@implementation DetalleViewController
@synthesize mapa,data,lati,longi,tempCoord,tempDescr,tempTitle;

-(id)initWithModel: (modelo *)aModel{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        _model = aModel;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    mapa.delegate =self;
   
    self.detalleEmail.text = [self infoNoDisponible:_tempMail];
    self.detalleTrans.text = [self infoNoDisponible:_tempTrans];
    
     self.detalleLugar.text = self.tempTitle;
    self.detalleDirec.text = self.tempDirec;
    
    /*
    self.detalleEmail.text = self.model.mail;
    self.detalleTrans.text = self.model.bus;
    
    self.detalleLugar.text = self.model.name;
    self.detalleDirec.text = self.model.addres;
    */

    
    [_button addTarget:self action:@selector(showModalViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self localizacion];
  
}
-(NSString *)infoNoDisponible:(NSString *)texto{
    
    NSString *temporal;
    
    if ([texto isEqualToString:@"null"]) {
        
        temporal = @"informacion no disponible";
    } else {
        temporal = texto;
    }
    return temporal;
}


-(void)showModalViewController {
    
    [self performSegueWithIdentifier: @"blurSegue"  sender:self];
}

-(void)localizacion{
    

    NSString *combined = tempCoord;
    NSArray *stringArray = [combined componentsSeparatedByString: @","];
    
    lati = [stringArray objectAtIndex:0];
    longi = [stringArray objectAtIndex:1];
    
    double latdouble = [lati doubleValue];
    double londouble = [longi doubleValue];
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = latdouble;
    annotationCoord.longitude = londouble;
    
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = tempTitle;
    annotationPoint.subtitle = _tempId;
    [mapa addAnnotation:annotationPoint];
    
    MKCoordinateRegion spain = MKCoordinateRegionMakeWithDistance(annotationCoord,
                                                                  1000000, 1000000);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotationCoord,
                                                                   500, 500);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapa setRegion:spain
                       animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mapa setRegion:region
                           animated:YES];
        });
    });
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *punto = @"punto";
    
    MKPinAnnotationView *chincheta;
    chincheta = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:punto];
    
    if (chincheta == nil) {
        chincheta = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                       reuseIdentifier:punto];
        // Asignamos color
        chincheta.pinColor = MKPinAnnotationColorPurple;
        
        // Callout
        chincheta.canShowCallout = YES;
        UIImageView *pt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
        
        chincheta.leftCalloutAccessoryView = pt;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [btn addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [chincheta setRightCalloutAccessoryView:btn];
        
    }
    return chincheta;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    DesViewController *destination = [[DesViewController alloc] init];
    [self.navigationController pushViewController:destination animated:YES];
    destination.temporalDes = tempDescr;
    destination.titulo = tempTitle;

}

- (IBAction)menu:(id)sender {
    DesViewController *destination = [[DesViewController alloc] init];
    [self.navigationController pushViewController:destination animated:YES];
    destination.temporalDes = tempDescr;
    destination.titulo = tempTitle;
}
@end
