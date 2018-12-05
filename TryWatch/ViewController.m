//
//  ViewController.m
//  TryWatch
//
//  Created by K.Lam on 2017/4/7.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "ViewController.h"
#import "TryWatchViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toTry {
    
    TryWatchViewController *tryVC = [[TryWatchViewController alloc] init];
    [self.navigationController pushViewController:tryVC animated:YES];
    
}

@end
