//
//  ViewController.h
//  Tic Tac Toe
//
//  Created by Alberto R. Estarrona on 11/6/18.
//  Copyright © 2018 Alberto R. Estarrona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonPos1;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos2;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos3;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos4;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos5;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos6;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos7;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos8;
@property (weak, nonatomic) IBOutlet UIButton *buttonPos9;

@property (weak, nonatomic) IBOutlet UIImageView *winningLine1;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine2;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine3;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine4;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine5;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine6;
@property (weak, nonatomic) IBOutlet UIImageView *winningLine78;

@end
