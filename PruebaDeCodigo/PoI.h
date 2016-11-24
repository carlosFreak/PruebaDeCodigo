//
//  PoI.h
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 2/8/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoI : NSObject


{
    
    NSString* name;
    NSString* address;
    NSString* link;
    NSString* coordinates;
    
}

- (NSString*) getName;
- (NSString*) getAddress;
- (NSString*) getLink;
- (NSString*) getCoordinates;

- (void) setName: (NSString*)input;
- (void) setAddress: (NSString*)input;
- (void) setLink: (NSString*)input;
- (void) setCoordinates: (NSString*)input;



@end
