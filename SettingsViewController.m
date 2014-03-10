//
//  SettingsViewController.m
//  tipcalc
//
//  Created by Chris Martin on 3/9/14.
//  Copyright (c) 2014 Chris Martin. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISwitch *hideKeyboardSwitch;

- (void)saveUserDefaults;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int defaultTip = [defaults integerForKey:@"default_tip"];
    self.defaultTipControl.selectedSegmentIndex = defaultTip;
    
    if ([defaults boolForKey:@"show_keyboard"]) {
        [self.hideKeyboardSwitch setOn:YES animated:YES];
    } else {
        [self.hideKeyboardSwitch setOn:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)defaultTipChanged:(id)sender {
    [self saveUserDefaults];
}

- (IBAction)hideKeyboardChanged:(id)sender {
    [self saveUserDefaults];
}

- (void)saveUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *tipValues = @[@(0), @(1), @(2)];
    float defaultTipAmount = [tipValues[self.defaultTipControl.selectedSegmentIndex] floatValue];
    
    [defaults setInteger:defaultTipAmount forKey:@"default_tip"];
    if(self.hideKeyboardSwitch.on) {
        [defaults setBool:YES forKey:@"show_keyboard"];
    } else {
        [defaults setBool:NO forKey:@"show_keyboard"];
    }
    [defaults synchronize];
}

@end
