//
//  MasterViewController.m
//  Best Commercials
//
//  Created by herku on 12/3/12.
//  Copyright (c) 2012 Advert.Ge. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Cell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    NSMutableArray *listOfItems;
    NSMutableArray *listOfImages;
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    

    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
     
    [self.refreshControl addTarget:self
                            action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self getData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *object =   [[listOfItems objectAtIndex:indexPath.row ]  valueForKey:@"name"];
    
    //NSString *imageUrl = [[listOfItems objectAtIndex:indexPath.row ]  valueForKey:@"image"];
    
   // NSURL *url = [NSURL URLWithString:imageUrl];
  
    
    
    cell.textLabel.text = [object description];
   // cell.imageView.image = [UIImage imageNamed:@"MyReallyCoolImage.png"];
    return cell;
    
    }







- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}





/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSString *object = [[listOfItems objectAtIndex:indexPath.row ]  valueForKey:@"name"];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [[listOfItems objectAtIndex:indexPath.row ]  valueForKey:@"url"];
        [[segue destinationViewController] setDetailItem:object];
    }
}



-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
 
    [self getData];
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                             [formatter stringFromDate:[NSDate date]]];
     refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
     [refresh endRefreshing];
 }
- (IBAction)refresh:(id)sender{

}


- (void)getData {
    
    NSString *url=@"http://www.advert.ge/api/";
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLResponse *resp = nil;
    NSError *err = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    //    NSString * theString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //    NSLog(@"response: %@", theString);
    
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", err);
    } else {

        listOfItems = [[NSMutableArray alloc] init];
                      
        for (NSDictionary *item in jsonArray){
            
             
            NSString *name = [NSString stringWithFormat:@"%@ - %@", [item valueForKey:@"brand"], [item valueForKey:@"name"]];
            NSString *image = [NSString stringWithFormat:@"http://www.advert.ge/videos/%@/thumb.jpg",[item valueForKey:@"alias"]];
            NSString *url = [NSString stringWithFormat:@"http://www.advert.ge/api/getcommercial/%@/",[item valueForKey:@"id"]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
            [dict setObject:name forKey:@"name"];
            [dict setObject:image forKey:@"image"];
            [dict setObject:url forKey:@"url"];
                       
            [listOfItems addObject:dict];
            



            
        }
    }
    
    


}

@end
