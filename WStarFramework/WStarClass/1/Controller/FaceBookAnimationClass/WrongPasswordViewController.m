//
//  WrongPasswordViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/18.
//  Copyright © 2016年 jf. All rights reserved.

#import "WrongPasswordViewController.h"
#import <pop/POP.h>

@interface WrongPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation WrongPasswordViewController
- (IBAction)login:(id)sender {
    
    POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    
    shake.springBounciness = 20;
    shake.velocity = @(3000);
    
    [self.passwordTextField.layer pop_addAnimation:shake forKey:@"shakePassword"];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
