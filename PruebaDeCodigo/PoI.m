//
//  PoI.m
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 2/8/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import "PoI.h"

@implementation PoI

- (void) setName: (NSString*)input
{
    name = input;
}

- (void) setAddress: (NSString*)input
{
    address = input;
}

- (void) setLink: (NSString*)input
{
    link = input;
}

- (void) setCoordinates: (NSString*)input
{
    coordinates = input;
}

- (NSString*) getName {
    return name;
}

- (NSString*) getAddress {
    return address;
}

- (NSString*) getLink {
    return link;
}

- (NSString*) getCoordinates {
    return coordinates;
}



@end
