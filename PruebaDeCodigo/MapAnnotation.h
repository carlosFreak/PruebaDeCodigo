//
//  MapAnnotation.h
//  PruebaDeCodigo
//
//  Created by Carlos jimenez on 29/07/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
