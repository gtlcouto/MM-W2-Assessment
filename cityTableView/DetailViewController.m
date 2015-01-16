//
//  DetailViewController.m
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *wikiLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;

@property BOOL isEditButtonPressed;


@end

@implementation DetailViewController

#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    //call loadUIElements helper method
    [self loadUIElements];



}


#pragma mark - IBActions
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)editButton {

    //Change if its Done, or Editing

    if (!self.isEditButtonPressed)
    {
        editButton.title = @"Done";

        self.nameTextField.text = self.nameLabel.text;
        self.stateTextField.text = self.stateLabel.text;

        [self sizeToFitAll];


    }
    else
    {
        editButton.title = @"Edit";
        self.nameLabel.text = self.nameTextField.text;
        self.stateLabel.text = self.stateTextField.text;

        self.selectedCity.name = self.nameLabel.text;
        self.selectedCity.state = self.stateLabel.text;

        [self sizeToFitAll];



    }
    self.isEditButtonPressed = !self.isEditButtonPressed;
    self.nameLabel.hidden = !self.nameLabel.hidden;
    self.nameTextField.hidden = !self.nameTextField.hidden;
    self.stateLabel.hidden = !self.stateLabel.hidden;
    self.stateTextField.hidden = !self.stateTextField.hidden;

}
//tap gesture action
- (IBAction)onTapGesture:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self.view];

    if (CGRectContainsPoint(self.wikiLabel.frame, touchPoint)) {
        [self performSegueWithIdentifier:@"webViewSegue" sender:self];
    }

}

- (IBAction)onSetTitleButtonPressed:(UIButton *)sender {
    [self.delegate onSetTitlePressed:self.nameLabel.text];
}


#pragma mark - Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController * vc = segue.destinationViewController;
    vc.selectedCity = self.selectedCity;


}


#pragma mark - Helper Methods

-(void)loadUIElements
{
    self.nameLabel.text = self.selectedCity.name;
    self.stateLabel.text = self.selectedCity.state;
    self.cityImageView.image = self.selectedCity.cityImage;
    self.nameTextField.hidden = true;
    self.stateTextField.hidden = true;
    [self sizeToFitAll];

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(onEditButtonPressed:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

//call sizeToFit on all labels and textfields
- (void)sizeToFitAll
{
    [self.nameLabel sizeToFit];
    [self.stateLabel sizeToFit];

    [self.nameTextField sizeToFit];
    [self.stateLabel sizeToFit];
}


@end
