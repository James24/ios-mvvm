//
//  RWTFlickrFilterViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrFilterViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrFilterViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) RWTFlickrFilterViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UISwitch *showViralSwitch;

@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;
@property (strong, nonatomic) UIPickerView *sectionPickerView;

@property (weak, nonatomic) IBOutlet UITextField *viewTypeTextField;
@property (strong, nonatomic) UIPickerView *viewTypePickerView;

@property (weak, nonatomic) IBOutlet UITextField *windowTextField;
@property (strong, nonatomic) UIPickerView *windowPickerView;

@property (weak, nonatomic) IBOutlet UITextField *sortTextField;
@property (strong, nonatomic) UIPickerView *sortPickerView;


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
    [self setupWindowPickerView];
    [self setupSortPickerView];
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
    
    self.sectionTextField.text = [self.viewModel.selectedFilterOptions.selectedSection prettyName];
    long sectionPickerIndexSelected = [[self.viewModel getArrayOfAllSectionTypes] indexOfObject:self.viewModel.selectedFilterOptions.selectedSection];
    self.viewModel.lastSectionIndexSelected = sectionPickerIndexSelected;
    [self.sectionPickerView selectRow:sectionPickerIndexSelected inComponent:0 animated:NO];
}

- (void)setupViewTypePicker{
    self.viewTypePickerView = [[UIPickerView alloc]init];
    self.viewTypePickerView.dataSource = self;
    self.viewTypePickerView.delegate = self;
    self.viewTypePickerView.showsSelectionIndicator = YES;
    self.viewTypeTextField.inputView = self.viewTypePickerView;
    
    self.viewTypeTextField.text = [self.viewModel.selectedViewType prettyName];
    long viewPickerIndexSelected = [[self.viewModel getArrayOfAllViewTypes] indexOfObject:self.viewModel.selectedViewType];
    [self.viewTypePickerView selectRow:viewPickerIndexSelected inComponent:0 animated:NO];

}

- (void)setupWindowPickerView{
    self.windowPickerView = [[UIPickerView alloc]init];
    self.windowPickerView.dataSource = self;
    self.windowPickerView.delegate = self;
    self.windowPickerView.showsSelectionIndicator = YES;
    self.windowTextField.inputView = self.windowPickerView;
}

- (void)setupSortPickerView{
    self.sortPickerView = [[UIPickerView alloc]init];
    self.sortPickerView.dataSource = self;
    self.sortPickerView.delegate = self;
    self.sortPickerView.showsSelectionIndicator = YES;
    self.sortTextField.inputView = self.sortPickerView;
    
    self.sortTextField.text = [self.viewModel.selectedFilterOptions.selectedSort prettyName];
    long sortPickerIndexSelected = [[self.viewModel getArrayOfAllSortTypes:[self userHasSelectedUserSection]] indexOfObject:self.viewModel.selectedFilterOptions.selectedSort];
    [self.sortPickerView selectRow:sortPickerIndexSelected inComponent:0 animated:NO];
}

- (void)setupSwitch{
    [self.showViralSwitch setOn:self.viewModel.selectedFilterOptions.showViral animated:YES];
}

- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    if (self.viewModel.selectedWindow) {
        self.windowTextField.text = [self.viewModel.selectedWindow prettyName];
        long windowPickerIndexSelected = [[self.viewModel getArrayOfAllWindowTypes] indexOfObject:self.viewModel.selectedWindow];
        self.viewModel.lastWindowTypeIndexSelected = windowPickerIndexSelected;
        [self.windowPickerView selectRow:windowPickerIndexSelected inComponent:0 animated:NO];
        
    } else {
        
        [self.windowPickerView selectRow:0 inComponent:0 animated:NO];
        self.windowTextField.text = [[self.viewModel getArrayOfAllWindowTypes][0] prettyName];
    }
    
    
    [RACObserve(self, viewModel.lastSectionIndexSelected) subscribeNext:^(NSNumber *x) {
        
        NSInteger arrayIndex = [x intValue];
        
        if ([[[self.viewModel getArrayOfAllSectionTypes] objectAtIndex:arrayIndex] sectionType] == RWTImgurApiRequestSectionTypeTop) {
            
            self.windowTextField.enabled = YES;
            
        } else {
            
            self.windowTextField.enabled = NO;
            
        }
        
        BOOL userHasSelectedAnySectionButUSer = [[[self.viewModel getArrayOfAllSectionTypes] objectAtIndex:arrayIndex] sectionType] != RWTImgurApiRequestSectionTypeUser;
        BOOL userHasSelectedRisingSortOption = [[self.viewModel getArrayOfAllSortTypes:YES][self.viewModel.lastSortTypeIndexSelected] sortType] == RWTImgurSortTypeRising;
        
        if (userHasSelectedAnySectionButUSer && userHasSelectedRisingSortOption) {
            
            self.sortTextField.text = [[[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeViral] prettyName];
            self.viewModel.lastSortTypeIndexSelected = 0;
            [self.sortPickerView selectRow:0 inComponent:0 animated:NO];
            
            [self.sortPickerView reloadAllComponents];
        }
    }];
    

}



- (void)cancelFilter{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyFilter{
    
    [self performFilterChanges];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self performViewTypeSelectionChange];
    }];
}

- (void)performFilterChanges{
    
    RWTImgurFilterOptions *filterOptions = [[RWTImgurFilterOptions alloc] init];
    filterOptions.selectedSection = [self.viewModel getArrayOfAllSectionTypes][self.viewModel.lastSectionIndexSelected];
    filterOptions.showViral = self.showViralSwitch.isOn;
    filterOptions.selectedSort = [self.viewModel getArrayOfAllSortTypes:[self userHasSelectedUserSection]][self.viewModel.lastSortTypeIndexSelected];
    
    RWTImgurWindow *newWindow = [self.viewModel getArrayOfAllWindowTypes][self.viewModel.lastWindowTypeIndexSelected];
    
    if ([self.windowTextField isEnabled]) {
        
        filterOptions.selectedWindow = newWindow;
        
    } else if (![self.windowTextField isEnabled]){
        
        filterOptions.selectedWindow = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeNone];
        
    }
    
    self.viewModel.selectedFilterOptions = filterOptions;
    
}

- (void)performViewTypeSelectionChange{
    
    RWTImgurViewType *viewType = [self.viewModel getArrayOfAllViewTypes][self.viewModel.lastViewTypeIndexSelected];
    
    if (![viewType isEqual:self.viewModel.selectedViewType]){
        self.viewModel.selectedViewType = viewType;
    }
}

- (BOOL)userHasSelectedUserSection{
    
    long indexSelected = self.viewModel.lastSectionIndexSelected;
    
    RWTImgurSection *sectionSelected = [self.viewModel getArrayOfAllSectionTypes][indexSelected];
    
    return sectionSelected.sectionType == RWTImgurApiRequestSectionTypeUser;
    
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.sectionPickerView) {
        return [[self.viewModel getArrayOfAllSectionTypes] count];
        
    } else if (pickerView == self.viewTypePickerView){
        
        return [[self.viewModel getArrayOfAllViewTypes] count];
        
    } else if (pickerView == self.windowPickerView){
        
        return [[self.viewModel getArrayOfAllWindowTypes] count];
        
    } else if (pickerView == self.sortPickerView) {
        
        return [[self.viewModel getArrayOfAllSortTypes:[self userHasSelectedUserSection]] count];
        
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.sectionPickerView) {
        
        RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
        return [section prettyName];
        
    } else if (pickerView == self.viewTypePickerView){
        
        RWTImgurViewType *viewType = [self.viewModel getArrayOfAllViewTypes][row];
        return [viewType prettyName];
        
    } else if (pickerView == self.windowPickerView){
        
        RWTImgurWindow *windowType = [self.viewModel getArrayOfAllWindowTypes][row];
        return [windowType prettyName];
        
    } else if (pickerView == self.sortPickerView) {
        
        return [[self.viewModel getArrayOfAllSortTypes:YES][row] prettyName];

    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.sectionPickerView) {
        
        self.viewModel.lastSectionIndexSelected = row;
        RWTImgurSection *section = [self.viewModel getArrayOfAllSectionTypes][row];
        self.sectionTextField.text = [section prettyName];
        
    } else if (pickerView == self.viewTypePickerView){
        
        self.viewModel.lastViewTypeIndexSelected = row;
        RWTImgurViewType *view = [self.viewModel getArrayOfAllViewTypes][row];
        self.viewTypeTextField.text = [view prettyName];
        
    } else if (pickerView == self.windowPickerView){

        self.viewModel.lastWindowTypeIndexSelected = row;
        RWTImgurWindow *windowType = [self.viewModel getArrayOfAllWindowTypes][row];
        self.windowTextField.text = [windowType prettyName];
        
    } else if (pickerView == self.sortPickerView){
        
        self.viewModel.lastSortTypeIndexSelected = row;
        RWTImgurSort *sort = [self.viewModel getArrayOfAllSortTypes:[self userHasSelectedUserSection]][row];
        self.sortTextField.text = [sort prettyName];
        
    }
}

@end
