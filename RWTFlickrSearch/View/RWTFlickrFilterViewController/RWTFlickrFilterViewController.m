//
//  RWTFlickrFilterViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrFilterViewController.h"

@interface RWTFlickrFilterViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) RWTFlickrFilterViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;
@property (weak, nonatomic) IBOutlet UISwitch *showViralSwitch;

@end

@implementation RWTFlickrFilterViewController

- (instancetype)initWIthViewModel:(RWTFlickrFilterViewModel *)viewModel {
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupController];
    [self setupSectionPicker];
    [self setupSwitch];
    [self bindViewModel];
}

#pragma mark - Private Methods

- (void)setupController{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelFilter)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(applyFilter)]];
}   

- (void)setupSectionPicker{
    UIPickerView* pickerView = [[UIPickerView alloc]init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    self.sectionTextField.inputView = pickerView;
}

- (void)setupSwitch{
    [self.showViralSwitch setOn:self.viewModel.showViral animated:YES];
}

- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    self.sectionTextField.text = [self.viewModel.selectedSection prettyName];
}

- (void)cancelFilter{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyFilter{
    
    [self performSectionSelectionChange];
    [self performViralSelectionChange];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)performSectionSelectionChange{
    
    
    RWTImgurSection *newSection = [self.viewModel getArrayOfAllSectionTypes][self.viewModel.lastSectionIndexSelected];
    
    if (newSection.sectionType != self.viewModel.selectedSection.sectionType){
        self.viewModel.selectedSection = newSection;
    }
}

- (void)performViralSelectionChange{
    
    self.viewModel.showViral = self.showViralSwitch.isOn;
    
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [[self.viewModel getArrayOfAllSectionTypes] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
    
    return [section prettyName];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.viewModel.lastSectionIndexSelected = row;
    
    RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
    
    self.sectionTextField.text = [section prettyName];
}

@end
