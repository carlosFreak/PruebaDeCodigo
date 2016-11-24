//
//  ViewController.m
//  PruebaDeCodigo
//
//  Created by Carlos jimenez on 29/07/15.
//  Copyright (c) 2015 Carlos jimenez. All rights reserved.
//

#import "ViewController.h"
#import "DetalleViewController.h"
#import "modelo.h"


@interface ViewController (){

    UIRefreshControl *refreshControl;
    
    NSString *valuesTitle2;
    NSString *valuesDes;
    NSString *valuesCoord;
    NSString *valuesTrans;
    NSString *valuesMail;
    NSString *valuesDire;
    
}

@property(nonatomic,retain) NSArray *searchResults;
@property(nonatomic,retain) NSArray *jsonP;
@property(nonatomic,retain) NSArray *values;

@end

@implementation ViewController
@synthesize tabla,jsonP,values,searchResults;



- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"Barcelona";
    self.searchDisplayController.searchBar.scopeButtonTitles = nil;
 
    tabla.delegate=self;
    tabla.dataSource=self;

    [self metodoJson];
    
    // Initialize the refresh control.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor lightGrayColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    
     [self.tabla addSubview:refreshControl];
    
}
- (void)reloadData
{
    [self.tabla reloadData];
    
    if (refreshControl) {
        
        [self metodoJson];
        
        [refreshControl endRefreshing];
    }
}
-(void)metodoJson
{
    NSURL *url = [NSURL URLWithString:@"http://t21services.herokuapp.com/points"];
    
    NSData *data =[NSData dataWithContentsOfURL:url];
    
    if (data==nil) {
        [self.tabla performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

    }else{
    //iniciamos el bloque
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    NSError *error;

    jsonP = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    values = [NSMutableArray arrayWithArray:[jsonP valueForKey:@"list"]];
        
    if(error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        
       for ( NSDictionary *datos in values )
        {
          //  NSLog(@"id: %@", datos[@"id"] );
           // NSLog(@"Title: %@", datos[@"title"] );
           // NSLog(@"geocoordinates: %@", datos[@"geocoordinates"] );
        }
    }
        [self.tabla performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
        
        
    }}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
         return [self.searchResults count];
    }else{
         return [self.values count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tabla dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

           if (tableView == self.searchDisplayController.searchResultsTableView) {
               cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
               cell.imageView.image = [UIImage imageNamed:@"icon.png"];

        }else{
            
            NSMutableArray *valuesTitle = [NSMutableArray arrayWithArray:[values valueForKey:@"title"]];
            NSMutableArray *valuesId = [NSMutableArray arrayWithArray:[values valueForKey:@"id"]];
            
            cell.textLabel.text = [valuesTitle objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [valuesId objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@"icon.png"];

        }
          return cell;
}

#pragma Search Methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    NSArray *valuesTitle = [NSArray arrayWithArray:[values valueForKey:@"title"]];
    self.searchResults = [valuesTitle filteredArrayUsingPredicate:predicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"adelante"]) {
     
        UINavigationController *navController = [segue destinationViewController];
        DetalleViewController *detalle = (DetalleViewController *)([navController viewControllers][0]);

       NSIndexPath *indexpath =nil;
        
        if ([self.searchDisplayController isActive]) {

            indexpath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];

            detalle.tempTitle =[self.searchResults objectAtIndex:indexpath.row];
            
            NSString *ident;
            
            for ( NSDictionary *datos in values ){
                
                if ([detalle.tempTitle isEqualToString:datos[@"title"]]) {
                    ident = datos[@"id"];
                    break;
                }
            }
         //   [self getPoiById:ident];
            
            [self setDetalleById:ident detalle:detalle];
            
          return;
        }else{
            
            indexpath = [self.tabla indexPathForSelectedRow];
            
            NSMutableArray *valuesTitle = [NSMutableArray arrayWithArray:[values valueForKey:@"title"]];
            
            NSString *ident;
            
            for ( NSDictionary *datos in values ){
                
                if ([[valuesTitle objectAtIndex:indexpath.row] isEqualToString:datos[@"title"]]) {
                    ident = datos[@"id"];
                    break;
                }
            }
         //   [self getPoiById:ident];

           [self setDetalleById:ident detalle:detalle];
        }
    }
}

-(modelo *)getPoiById:(NSString *)idParam{
    
    
 //   DetalleViewController *detalle =[DetalleViewController new];

    NSMutableString *postString = [NSMutableString stringWithString:@"http://t21services.herokuapp.com/points/"];
    
    [postString appendString:[NSString stringWithFormat:@"%@",idParam]];
    
    NSURL *url = [NSURL URLWithString:postString];
    
    NSData *data =[NSData dataWithContentsOfURL:url];
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *valuesDes = [json valueForKey:@"description"];
    NSString *valuesCoord = [json valueForKey:@"geocoordinates"];
    NSString *valuesTrans = [json valueForKey:@"transport"];
    NSString *valuesMail = [json valueForKey:@"email"];
    NSString *valuesDire = [json valueForKey:@"address"];
    NSString *valuesTitle2 = [json valueForKey:@"title"];
    NSString *valuesId = [json valueForKey:@"id"];

    
 /*
    detalle.tempDescr = valuesDes;
    detalle.tempTrans = valuesTrans;
    detalle.tempMail = valuesMail;
    detalle.tempDirec = valuesDire;
    detalle.tempCoord = valuesCoord;
*/
    
  modelo *model = [[modelo alloc] initWithName:valuesTitle2
                     idx:valuesId
            coordenadas:valuesCoord
              direccion:valuesDire
            descripcion:valuesDes
                  email:valuesMail
                    bus:valuesTrans];
 
    return model;
}

-(void)setDetalleById:(NSString *)idParam
              detalle:(DetalleViewController *) _Detalle{
    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://t21services.herokuapp.com/points/"];
    
    [postString appendString:[NSString stringWithFormat:@"%@",idParam]];
    
    NSURL *url = [NSURL URLWithString:postString];
    
    NSData *data =[NSData dataWithContentsOfURL:url];
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    valuesTitle2 = [json valueForKey:@"title"];
    valuesDes = [json valueForKey:@"description"];
    valuesCoord = [json valueForKey:@"geocoordinates"];
    valuesTrans = [json valueForKey:@"transport"];
    valuesMail = [json valueForKey:@"email"];
    valuesDire = [json valueForKey:@"address"];
    
    _Detalle.tempTitle = valuesTitle2;
    _Detalle.tempDescr = valuesDes;
    _Detalle.tempCoord = valuesCoord;
    _Detalle.tempTrans = valuesTrans;
    _Detalle.tempMail = valuesMail;
    _Detalle.tempDirec = valuesDire;
    
}







@end
