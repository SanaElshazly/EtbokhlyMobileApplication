//
//  HomePageTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "HomePageTableViewController.h"

@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    networkDelegate=self;
    mealsRequestedService = [[MealsServices alloc] initWithNetWorkDelegate:networkDelegate];
    cooksRequestedMeals=[[CookServices alloc]initWithNetworkDelegate:networkDelegate];
    
    [self changeValueOfSegmentedController:self];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"allMeals"]) {
        meals = [[NSArray alloc] initWithArray:dataRetreived];
        
    }
    else if ([serviceName isEqualToString:@"allCooks"])
    {
        cooks=[[NSArray alloc] initWithArray:dataRetreived];
    }
    [self refreshDataInTableView];
    NSLog(@"meals data %@", meals );
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView function");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection function");
    NSInteger arrayLength=0;
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            arrayLength = [cooks count];
            NSLog(@"arrayLength of cooks %d", arrayLength);
            break;
            
        case 1:
            arrayLength = [meals count];
            NSLog(@"arrayLength of meals %d", arrayLength);
            break;
            
        default:
            break;
    }
    return arrayLength;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath function");
    
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            cell.textLabel.text=[[cooks objectAtIndex:indexPath.row] objectForKey:@"name"];
            break;
            
        case 1:
            cell.textLabel.text=[[meals objectAtIndex:indexPath.row] objectForKey:@"nameEn"];
            break;
        default:
            break;
    }
    
    return cell;
}


-(void)refreshDataInTableView
{
    [self.dataTableView reloadData];
}

-(IBAction)changeValueOfSegmentedController:(id)sender {
    NSLog(@"3mlt aho");
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            [cooksRequestedMeals getCooksListDataService];
            break;
        case 1 :
            //[self getMealsListDataService];
            [mealsRequestedService getMealsListDataService];
            NSLog(@"%@",meals);
            //[self refreshDataInTableView];
            break;
        default:
            break;
    }
}


@end
