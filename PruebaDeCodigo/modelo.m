//
//  modelo.m
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 3/8/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import "modelo.h"

@implementation modelo

-(id)initWithName :(NSString *)aName
                idx:(NSString *)aId
       coordenadas:(NSString*)aCoord
         direccion:(NSString*)aDress
      descripcion :(NSString *)aDes
            email :(NSString *)amail
            bus:(NSString *)aBus
{

    if (self =[super init]){
    
        _name = aName;
        _Idx = aId;
        _coord = aCoord;
        _addres = aDress;
        _des = aDes;
        _mail = amail;
        _bus = aBus;
    
    }
    return self;

}

@end
