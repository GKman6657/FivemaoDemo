//
//  FacebookButtonAnimationViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/18.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "FacebookButtonAnimationViewController.h"
#import <pop/POP.h>
@interface FacebookButtonAnimationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTxf;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation FacebookButtonAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputTxf.delegate = self;
    self.sendBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *comment;
    if(range.length == 0)
    {
        comment = [NSString stringWithFormat:@"%@%@", textField.text, string];
    }
    else
    {
        comment = [textField.text substringToIndex:textField.text.length - range.length];
    }
    
    if (comment.length == 0) {
        //Show like
        [self showLikeButton];
    }
    else
    {
        //Show Send
        [self showSendButton];
    }
    return YES;
}
-(void)showLikeButton
{
    self.likeBtn.hidden = NO;
    self.sendBtn.hidden = YES;
    
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(0);
    spin.springBounciness = 20;
    spin.velocity = @(10);
    [self.likeBtn.layer pop_addAnimation:spin forKey:@"likeAnimation"];
}

-(void)showSendButton
{
    if (self.sendBtn.isHidden) {
        
        self.likeBtn.hidden = YES;
        self.sendBtn.hidden = NO;
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
        sprintAnimation.springBounciness = 20.f;
        [self.sendBtn pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
    }
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
