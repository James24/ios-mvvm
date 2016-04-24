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
}

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

- (void)cancelFilter{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyFilter{
    [self dismissViewControllerAnimated:YES completion:nil];    
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"test";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%ld",(long)row);
    
}

@end
