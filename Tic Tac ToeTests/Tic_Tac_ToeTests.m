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

@end

@implementation Tic_Tac_ToeTests

- (void)setUp {
    [super setUp];
    
    self.vcTest = [[ViewController alloc] init];
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

@end
