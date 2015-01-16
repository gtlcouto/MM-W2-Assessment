//
//  ViewController.m
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "City.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, DetailViewDelegate>

@property NSMutableArray * cityArray;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property NSIndexPath * deleteIndexPath;
@property City * currentCity;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;


@end

@implementation ViewController


#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    //call populate array method
    [self populateArrayWithCities];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.cityTableView reloadData];
}




#pragma mark - TableView Delegate Methods

//TableViewDataSource Delegate Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityArray.count;
}



//populate our prototype "cell"
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    City *city =  [self.cityArray objectAtIndex:indexPath.row];

    cell.textLabel.text = city.name;

    cell.detailTextLabel.text = city.state;
    

    cell.imageView.image = [self resizeImage:city.cityImage imageSize:CGSizeMake(70, 70)];


    return cell;
}

//Commits whatever was done during editing mode
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *deleteAlert = [UIAlertView new];
    deleteAlert.delegate = self;
    deleteAlert.title = @"Are you sure you would like to delete this item?";
    [deleteAlert addButtonWithTitle:@"Cancel"];
    [deleteAlert addButtonWithTitle:@"Delete"];
    self.deleteIndexPath = indexPath;
    [deleteAlert show];
}


#pragma mark - AlertView Delegate Methods
//alertview button clicked
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.cityArray removeObjectAtIndex:self.deleteIndexPath.row];
        [self.cityTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}


#pragma mark - Custom Delegate Methods
-(void)onSetTitlePressed:(NSString *)title
{
    self.titleItem.title = title;
}

#pragma mark - IBActions

//Initializing edit mode and changine the button title text when pressed
- (IBAction)onEditButtonPressed:(UIButton *)editButton
{
    if ([editButton.titleLabel.text  isEqual: @"Edit"])
    {
        [editButton setTitle:@"Done" forState:UIControlStateNormal];
        [editButton sizeToFit];
        self.cityTableView.editing = YES;
    }
    else
    {
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        self.cityTableView.editing = NO;
    }
}


#pragma mark - Segue Methods

//send necessary informaton to detailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        DetailViewController *detailVC = segue.destinationViewController;
        //set delegate to self
        detailVC.delegate = self;

        NSIndexPath *myIndexPath = [self.cityTableView
                                    indexPathForSelectedRow];
        self.currentCity = [self.cityArray objectAtIndex:myIndexPath.row];

        detailVC.selectedCity = self.currentCity;
    }
}





#pragma mark - Helper Methods
//Generate 4 cities and put them inside self.CityArray
-(void)populateArrayWithCities
{
    City *rioDeJaneiro = [[City alloc] initWithName:@"Rio de Janeiro" aState:@"Rio de Janeiro" anImage:[UIImage imageNamed:@"riodejaneiro.png"]];
    City *toronto = [[City alloc] initWithName:@"Toronto" aState:@"Ontario" anImage:[UIImage imageNamed:@"toronto.png"]];
    City *lasVegas = [[City alloc] initWithName:@"Las Vegas" aState:@"Nevada" anImage:[UIImage imageNamed:@"lasvegas.png"]];
    City *florianopolis = [[City alloc] initWithName:@"Florianopolis" aState:@"Santa Catarina" anImage:[UIImage imageNamed:@"florianopolis.png"]];
     self.cityArray = [[NSMutableArray alloc] initWithObjects:rioDeJaneiro, toronto, lasVegas, florianopolis, nil];
}

//Takes UIImage and rezises it to the second paremeter
-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
