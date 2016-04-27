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
@property (strong, nonatomic) UIPickerView *sectionPickerView;

@property (weak, nonatomic) IBOutlet UITextField *viewTypeTextField;
@property (strong, nonatomic) UIPickerView *viewTypePickerView;

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
    [self setupViewTypePicker];
    [self setupSwitch];
    [self bindViewModel];
}

#pragma mark - Private Methods

- (void)setupController{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelFilter)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(applyFilter)]];
}   

- (void)setupSectionPicker{
    self.sectionPickerView = [[UIPickerView alloc]init];
    self.sectionPickerView.dataSource = self;
    self.sectionPickerView.delegate = self;
    self.sectionPickerView.showsSelectionIndicator = YES;
    self.sectionTextField.inputView = self.sectionPickerView;
}

- (void)setupViewTypePicker{
    self.viewTypePickerView = [[UIPickerView alloc]init];
    self.viewTypePickerView.dataSource = self;
    self.viewTypePickerView.delegate = self;
    self.viewTypePickerView.showsSelectionIndicator = YES;
    self.viewTypeTextField.inputView = self.viewTypePickerView;
}

- (void)setupSwitch{
    [self.showViralSwitch setOn:self.viewModel.showViral animated:YES];
}

- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    self.sectionTextField.text = [self.viewModel.selectedSection prettyName];
    int sectionPickerIndexSelected = [[self.viewModel getArrayOfAllSectionTypes] indexOfObject:self.viewModel.selectedSection];
    [self.sectionPickerView selectRow:sectionPickerIndexSelected inComponent:0 animated:NO];
    
    self.viewTypeTextField.text = [self.viewModel.selectedViewType prettyName];
    int viewPickerIndexSelected = [[self.viewModel getArrayOfAllViewTypes] indexOfObject:self.viewModel.selectedViewType];
    [self.sectionPickerView selectRow:viewPickerIndexSelected inComponent:0 animated:NO];
}

- (void)cancelFilter{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyFilter{
    
    [self performSectionSelectionChange];
    [self performViralSelectionChange];
    [self performViewTypeSelectionChange];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)performSectionSelectionChange{
    
    
    RWTImgurSection *newSection = [self.viewModel getArrayOfAllSectionTypes][self.viewModel.lastSectionIndexSelected];
    
    if (![newSection isEqual:self.viewModel.selectedSection]){
        self.viewModel.selectedSection = newSection;
    }
}

- (void)performViralSelectionChange{
    
    self.viewModel.showViral = self.showViralSwitch.isOn;
}

- (void)performViewTypeSelectionChange{
    
    RWTImgurViewType *viewType = [self.viewModel getArrayOfAllViewTypes][self.viewModel.lastViewTypeIndexSelected];
    
    if (![viewType isEqual:self.viewModel.selectedViewType]){
        self.viewModel.selectedViewType = viewType;
    }
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.sectionPickerView) {
        return [[self.viewModel getArrayOfAllSectionTypes] count];
        
    } else {
        return [[self.viewModel getArrayOfAllViewTypes] count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.sectionPickerView) {
        RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
        return [section prettyName];
        
    } else {
        RWTImgurViewType *viewType = [self.viewModel getArrayOfAllViewTypes][row];
        return [viewType prettyName];
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.sectionPickerView) {
        
        self.viewModel.lastSectionIndexSelected = row;
        RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
        self.sectionTextField.text = [section prettyName];
        
    } else {
        
        self.viewModel.lastViewTypeIndexSelected = row;
        RWTImgurViewType *view = [self.viewModel getArrayOfAllViewTypes][row];
        self.viewTypeTextField.text = [view prettyName];
    }
}

@end
