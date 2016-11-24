//
//  modelo.h
//  PruebaDeCodigo
//
//  Created by Carlos Jimenez on 3/8/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface modelo : NSObject


@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *Idx;
@property (strong, nonatomic)NSString *coord;
@property (strong, nonatomic)NSString *addres;
@property (strong, nonatomic)NSString *des;
@property (strong, nonatomic)NSString *mail;
@property (strong, nonatomic)NSString *bus;


-(id)initWithName :(NSString *)aName
                idx:(NSString *)aId
       coordenadas:(NSString*)aCoord
         direccion:(NSString*)aDress
      descripcion :(NSString *)aDes
            email :(NSString *)amail
            bus :(NSString *)aBus;





@end
