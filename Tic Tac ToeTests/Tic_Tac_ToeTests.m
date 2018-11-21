//
//  Tic_Tac_ToeTests.m
//  Tic Tac ToeTests
//
//  Created by Alberto R. Estarrona on 11/6/18.
//  Copyright © 2018 Alberto R. Estarrona. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Tic_Tac_ToeTests : XCTestCase

@property (nonatomic) ViewController *vcTest;
@property (nonatomic, retain) UIButton* button1;
@property (nonatomic, retain) UIButton* button2;
@property (nonatomic, retain) UIButton* button3;
@property (nonatomic, retain) UIButton* button4;
@property (nonatomic, retain) UIButton* button5;
@property (nonatomic, retain) UIButton* button6;
@property (nonatomic, retain) UIButton* button7;
@property (nonatomic, retain) UIButton* button8;
@property (nonatomic, retain) UIButton* button9;

@end

@implementation Tic_Tac_ToeTests

- (void)setUp {
    [super setUp];
    
    self.vcTest = [[ViewController alloc] init];
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button9 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.vcTest.buttonPos1 = self.button1;
    self.vcTest.buttonPos2 = self.button2;
    self.vcTest.buttonPos3 = self.button3;
    self.vcTest.buttonPos4 = self.button4;
    self.vcTest.buttonPos5 = self.button5;
    self.vcTest.buttonPos6 = self.button6;
    self.vcTest.buttonPos7 = self.button7;
    self.vcTest.buttonPos8 = self.button8;
    self.vcTest.buttonPos9 = self.button9;
    
    [self.vcTest initGame:nil];
}

- (void)testKillingMove {
    int position = [self.vcTest checkForKillingMove];
    XCTAssertEqual(position, -1);
}

-(void)testSearchForBlankSpot {
    int position = [self.vcTest searchBlankSpotFor:0];
    XCTAssertEqual(position, 2);
}

-(void)testForBlankCorner {
    int position = [self.vcTest nextBlankCornerFor:8];
    XCTAssertEqual(position, 2);
}

-(void)testForWinningPosition {
    int position = [self.vcTest chekWinningPositionWith:3];
    XCTAssertEqual(position, 0);
}

-(void)testGetPosition {
    int position = [self.vcTest getPosition:self.vcTest.buttonPos1];
    XCTAssertEqual(position, 0);
}

/*
 self.vcTest.positions[]:
 
     |     |
 [0] | [1] | [2]
 -----------------
 [3] | [4] | [5]
 -----------------
 [6] | [7] | [8]
     |     |
 
 Buttons order:
 
         |          |
 button1 | button2  | button3
 -----------------------------
 button4 | button5  | button6
 -----------------------------
 button7 | button8  | button9
         |          |
 
 */

-(void)testWhenPlayerGoCorners {
    // The AI must play to the center if Player chooses any corner at beginning
    
    // Player selected upper left corner (positions[0] - button1)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos1];
    // AI MUST go to center position -> Set positions[4] = -33
    [self.vcTest makeInitalMove];
    int value = [self.vcTest.positions[4] intValue];
    
    // position[4] (center) it's COMPUTER's
    XCTAssertEqual(value, -33);
    
    // Will reset the board to test next corner
    [self.vcTest initGame:nil];
    
    // Player selected upper right corner (positions[2] - button3)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos3];
    // AI MUST go to center position -> Set positions[4] = -33
    [self.vcTest makeInitalMove];
    value = [self.vcTest.positions[4] intValue];
    
    // position[4] (center) it's COMPUTER's
    XCTAssertEqual(value, -33);
    
    // Will reset the board to test next corner
    [self.vcTest initGame:nil];
    
    // Player selected upper right corner (positions[6] - button7)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos3];
    // AI MUST go to center position -> Set positions[8] = -33
    [self.vcTest makeInitalMove];
    value = [self.vcTest.positions[4] intValue];
    
    // position[4] (center) it's COMPUTER's
    XCTAssertEqual(value, -33);
    
    // Will reset the board to test next corner
    [self.vcTest initGame:nil];
    
    // Player selected upper right corner (positions[8] - button9)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos3];
    // AI MUST go to center position -> Set positions[4] = -33
    [self.vcTest makeInitalMove];
    value = [self.vcTest.positions[4] intValue];
    
    // position[4] (center) it's COMPUTER's
    XCTAssertEqual(value, -33);
}

-(void)testComputerAttack {
    // The AI must try to attack instead of just defend itself
    
    // Player selected upper right corner (positions[2] - button3)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos3];
    // AI MUST go to center position
    [self.vcTest makeInitalMove];
 
    // Player selected lower right corner (positions[8] - button9)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos9];
    
    // COMPUTER's response to that selected position
    int nextPosition = [self.vcTest chekWinningPositionWith:8];
    [self.vcTest setUIPosition:nextPosition forPlayer: COMPUTER];
    
    int value = [self.vcTest.positions[5] intValue];
    // position[5] should be taken by COMPUTER (value = -99) to attack instead of wait for PLAYER strategy
    XCTAssertEqual(value, -99);
}

-(void)testComputerSelectsBestCorner {
    // The AI must select the as its second move a corner, if there is an upcoming attack on that position
    
    // Player selected center right position (positions[5] - button6)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos6];
    // AI MUST go to center position
    [self.vcTest makeInitalMove];
    
    // Player's next move is center down position (positions[7] - button8)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos8];
    
    // COMPUTER's response to that selected position
    int nextPosition = [self.vcTest chekWinningPositionWith:7];
    [self.vcTest setUIPosition:nextPosition forPlayer: COMPUTER];
    
    int value = [self.vcTest.positions[8] intValue];
    // position[8] should be taken by COMPUTER (value = -999) to attack on diagonal and prevent at the same time the PLAYER's attack on that corner
    XCTAssertEqual(value, -999);
    
    
    // Will reset the board to test another situation
    [self.vcTest initGame:nil];
    
    // Player selected upper right position (positions[1] - button2)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos2];
    // AI MUST go to center position
    [self.vcTest makeInitalMove];
    
    // Player's next move is center left position (positions[3] - button4)
    [self.vcTest didSelectPosition:self.vcTest.buttonPos4];
    
    // COMPUTER's response to that selected position
    nextPosition = [self.vcTest chekWinningPositionWith:3];
    [self.vcTest setUIPosition:nextPosition forPlayer: COMPUTER];
    
    value = [self.vcTest.positions[0] intValue];
    // position[0] should be taken by COMPUTER (value = -1) to attack on diagonal and prevent at the same time the PLAYER's attack on that corner
    XCTAssertEqual(value, -1);
}

@end
