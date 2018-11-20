//
//  ViewController.m
//  Tic Tac Toe
//
//  Created by Alberto R. Estarrona on 11/6/18.
//  Copyright © 2018 Alberto R. Estarrona. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    @private  int turn;
    @private    NSMutableArray *positions;
    @private    int valuePosition;
    @private    int win;
}

@end
int const NO_WINNER = 0;
int const WINNER_X = 1;
int const WINNER_O = 2;

int const PLAYER = 0;
int const COMPUTER = 1;

@implementation ViewController
@synthesize buttonPos1, buttonPos2, buttonPos3, buttonPos4, buttonPos5, buttonPos6, buttonPos7, buttonPos8, buttonPos9, winningLine1, winningLine2, winningLine3, winningLine4, winningLine5, winningLine6, winningLine78, msgLabel, buttonStart, positions;

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
 * Method IBAction to initialize a new game: resets UI and state vars
 */
- (IBAction)initGame:(id)sender {
    // Set all initial conditions
    turn = 0;
    win = NO_WINNER;
    id objects = @[@0, @0, @0, @0, @0, @0, @0, @0, @0];
    positions = [NSMutableArray arrayWithCapacity:9];
    [positions addObjectsFromArray:objects];
    /*for (int index = 0; index < 9; index++) {
        positions[index] = 0;
    }*/
    
    // Reset UI
    [self resetButtons];
}

/*
 * Method to reset all UI components for a new game
 */
- (void)resetButtons {
    [buttonPos1 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos2 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos3 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos4 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos5 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos6 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos7 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos8 setTitle:@" " forState:UIControlStateNormal ];
    [buttonPos9 setTitle:@" " forState:UIControlStateNormal ];
    buttonPos1.enabled = true; buttonPos2.enabled = true;
    buttonPos3.enabled = true; buttonPos4.enabled = true;
    buttonPos5.enabled = true; buttonPos6.enabled = true;
    buttonPos7.enabled = true; buttonPos8.enabled = true;
    buttonPos9.enabled = true;
    winningLine1.hidden = true; winningLine2.hidden = true;
    winningLine3.hidden = true; winningLine4.hidden = true;
    winningLine5.hidden = true; winningLine6.hidden = true;
    winningLine78.hidden = true;
    msgLabel.text = @"Please go first and try your best shot my friend.";
    [buttonStart setTitle:@"Restart game" forState:UIControlStateNormal ];
}

/*
 * Method IBAction to Kick off for all game functions by the user interaction
 * @param sender: Button presed on screen
 */
-(IBAction)didSelectPosition:(id)sender {
    double delayInSeconds = 0.7;
    
    if (turn != 9) {
        msgLabel.text = @"";
        turn++;
        int nextPosition;
        int positionSelected = [self getPosition:sender];
        [self setUIPosition:positionSelected forPlayer:PLAYER];
        
        switch (turn) {
            case 1:{
                positions[positionSelected] = @(valuePosition);
                turn++;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self makeInitalMove];
                });
                return;
            } break;
            case 3:{
                positions[positionSelected] = @(valuePosition);
            } break;
            case 5: {
                positions[positionSelected] = @(valuePosition);
            } break;
            case 7: {
                positions[positionSelected] = @(valuePosition);
            } break;
            case 9: {
                positions[positionSelected] = @(valuePosition);
            } break;
                
            default:
                break;
        }
        
        nextPosition = [self chekWinningPositionWith:positionSelected];
        if (nextPosition >= 0 && turn != 9) {
            turn++;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self setUIPosition:nextPosition forPlayer: COMPUTER];
                [self chekWinningPositionWith:nextPosition];
            });
        }
        
        if (win == NO_WINNER && turn == 9) {
            [self setFinalMessage];
        }
    }
}

/*
 * Method to identify the position on screen selected by the user. Sets the value on positions[] to identify later the player on that position
 * @param button: Button presed on screen
 * @return int: The position selected on screen
 */
-(int)getPosition:(id)button {
    int position = 0;
    if (button == buttonPos1) {
        buttonPos1.enabled = false;
        position = 0;
        valuePosition = 1;
    } else if (button == buttonPos2) {
        buttonPos2.enabled = false;
        position = 1;
        valuePosition = 3;
    } else if (button == buttonPos3) {
        buttonPos3.enabled = false;
        position = 2;
        valuePosition = 9;
    } else if (button == buttonPos4) {
        buttonPos4.enabled = false;
        position = 3;
        valuePosition = 11;
    } else if (button == buttonPos5) {
        buttonPos5.enabled = false;
        position = 4;
        valuePosition = 33;
    } else if (button == buttonPos6) {
        buttonPos6.enabled = false;
        position = 5;
        valuePosition = 99;
    } else if (button == buttonPos7) {
        buttonPos7.enabled = false;
        position = 6;
        valuePosition = 111;
    } else if (button == buttonPos8) {
        buttonPos8.enabled = false;
        position = 7;
        valuePosition = 333;
    } else if (button == buttonPos9) {
        buttonPos9.enabled = false;
        position = 8;
        valuePosition = 999;
    }
    return position;
}

/*
* Method to mark on screen the sign depending on the player in turn and draw the respective move
* @param position: Position on screen where the sign should be rendered
* @param player: Player in turn
*/
-(void)setUIPosition:(int) position forPlayer:(int) player {
    NSString *signChar = [[NSString alloc] init];
    if (turn % 2 == 0) {
        signChar = @"O";
    } else {
        signChar = @"X";
    }
    switch (position) {
        case 0:
            if (player == COMPUTER) {
                [self getPosition:buttonPos1];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos1 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 1:
            if (player == COMPUTER) {
                [self getPosition:buttonPos2];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos2 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 2:
            if (player == COMPUTER) {
                [self getPosition:buttonPos3];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos3 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 3:
            if (player == COMPUTER) {
                [self getPosition:buttonPos4];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos4 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 4:
            if (player == COMPUTER) {
                [self getPosition:buttonPos5];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos5 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 5:
            if (player == COMPUTER) {
                [self getPosition:buttonPos6];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos6 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 6:
            if (player == COMPUTER) {
                [self getPosition:buttonPos7];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos7 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 7:
            if (player == COMPUTER) {
                [self getPosition:buttonPos8];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos8 setTitle:signChar forState:UIControlStateNormal];
            break;
        case 8:
            if (player == COMPUTER) {
                [self getPosition:buttonPos9];
                positions[position] = @(-1 * valuePosition);
            }
            [buttonPos9 setTitle:signChar forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

/*
 * Method for the computer's first movement, contemplating the game's strategy
 */
-(void)makeInitalMove {
    if ([positions[4] intValue] == 0) {
        [self setUIPosition:4 forPlayer:COMPUTER];
    } else if ([positions[0] intValue] == 0) {
        [self setUIPosition:0 forPlayer:COMPUTER];
    } else {
        [self setUIPosition:2 forPlayer:COMPUTER];
    }
}

/*
 * Method to render on screen the red line indicating the winning line for any given player
 * @param lineNumber: Position on screen where the line should be displayed
 */
-(void)makeWinningLineWith:(int) lineNumber {
    if (turn % 2 == 0) {
        win = WINNER_O;
    } else {
        win = WINNER_X;
    }
    switch (lineNumber) {
        case 1: {
            winningLine1.hidden = false;
            turn = 9;
        } break;
        case 2: {
            winningLine2.hidden = false;
            turn = 9;
        } break;
        case 3: {
            winningLine3.hidden = false;
            turn = 9;
        } break;
        case 4: {
            winningLine4.hidden = false;
            turn = 9;
        } break;
        case 5: {
            winningLine5.hidden = false;
            turn = 9;
        } break;
        case 6: {
            winningLine6.hidden = false;
            turn = 9;
        } break;
        case 7: {
            [winningLine78 setImage:[UIImage imageNamed: @"line45.png"]];
            winningLine78.hidden = false;
            turn = 9;
        } break;
        case 8: {
            [winningLine78 setImage:[UIImage imageNamed: @"line45r.png"]];
            winningLine78.hidden = false;
            turn = 9;
        } break;
        default:
            break;
    }
    
    [self setFinalMessage];
}

/*
 * Method to render the announcement of the winning player
 */
-(void)setFinalMessage {
    if (win) {
        if (win == WINNER_X) {
            msgLabel.text = @"Wow! This is impossible... \nYou won.";
        } else {
            msgLabel.text = @"Sorry... but I won.";
        }
    } else {
        msgLabel.text = @"Draw! Good game, really enjoyed it my friend.";
    }
    [buttonStart setTitle:@"Try again?" forState:UIControlStateNormal ];
}

/*
 * Method to identify then next blank corner, if any.
 * @param position: Position on screen selected by the player
 * @return int: The position on screen if available or -1 if not.
 */
-(int)nextBlankCornerFor:(int) position {
    int blankCorener = -1;
    
    switch (position) {
        case 0:
            if ([positions[2] intValue] == 0) blankCorener = 2;
            else if ([positions[6] intValue] == 0) blankCorener = 6;
            else if ([positions[8] intValue] == 0) blankCorener = 8;
            break;
        case 2:
            if ([positions[0] intValue] == 0) blankCorener = 0;
            else if ([positions[6] intValue] == 0) blankCorener = 6;
            else if ([positions[8] intValue] == 0) blankCorener = 8;
            break;
        case 6:
            if ([positions[2] intValue] == 0) blankCorener = 2;
            else if ([positions[2] intValue] == 0) blankCorener = 2;
            else if ([positions[8] intValue] == 0) blankCorener = 8;
            break;
        case 8:
            if ([positions[2] intValue] == 0) blankCorener = 2;
            else if ([positions[6] intValue] == 0) blankCorener = 6;
            else if ([positions[0] intValue] == 0) blankCorener = 0;
            break;
        default:
            break;
    }
    
    return blankCorener;
}

/*
 * Method to identify the position on screen where the computer can win the match, if there is any chance at its current turn.
 * @return int: The position on screen if available or -1 if not.
 */
-(int)checkForKillingMove {
    int killingPosition = -1;
    
    if ([positions[0] intValue] + [positions[1] intValue] + [positions[2] intValue] == -4) killingPosition = 2;
    else if ([positions[0] intValue] + [positions[1]  intValue] + [positions[2] intValue] == -10 ) killingPosition = 1;
    else if ([positions[0] intValue] + [positions[1] intValue] + [positions[2] intValue] == -12 ) killingPosition = 0;
    else if ([positions[3] intValue] + [positions[4] intValue] + [positions[5] intValue] == -44 ) killingPosition = 5;
    else if ([positions[3] intValue] + [positions[4] intValue] + [positions[5] intValue] == -110 ) killingPosition = 4;
    else if ([positions[3] intValue] + [positions[4] intValue] + [positions[5] intValue] == -132 ) killingPosition = 3;
    else if ([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue] == -444 ) killingPosition = 8;
    else if ([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue] == -1110 ) killingPosition = 7;
    else if ([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue] == -1332 ) killingPosition = 6;
    
    else if ([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue] == -12 ) killingPosition = 6;
    else if ([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue] == -112 ) killingPosition = 3;
    else if ([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue] == -122 ) killingPosition = 0;
    else if ([positions[1] intValue] + [positions[4] intValue] + [positions[7] intValue] == -36 ) killingPosition = 7;
    else if ([positions[1] intValue] + [positions[4] intValue] + [positions[7] intValue] == -336 ) killingPosition = 4;
    else if ([positions[1] intValue] + [positions[4] intValue] + [positions[7] intValue] == -366 ) killingPosition = 1;
    else if ([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue] == -108 ) killingPosition = 8;
    else if ([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue] == -1008 ) killingPosition = 5;
    else if ([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue] == -1098 ) killingPosition = 2;
    
    else if ([positions[0] intValue] + [positions[4] intValue] + [positions[8] intValue] == -34 ) killingPosition = 8;
    else if ([positions[0] intValue] + [positions[4] intValue] + [positions[8] intValue] == -1000 ) killingPosition = 4;
    else if ([positions[0] intValue] + [positions[4] intValue] + [positions[8] intValue] == -1032 ) killingPosition = 0;
    else if ([positions[6] intValue] + [positions[4] intValue] + [positions[2] intValue] == -42 ) killingPosition = 6;
    else if ([positions[6] intValue] + [positions[4] intValue] + [positions[2] intValue] == -120 ) killingPosition = 4;
    else if ([positions[6] intValue] + [positions[4] intValue] + [positions[2] intValue] == -144 ) killingPosition = 2;
    
    return killingPosition;
}

/*
 * Method to identify the next best position for the computer's move.
 * @param position: Position on screen of the player's last movement
 * @return int: The position on screen for the movement
 */
-(int)searchBlankSpotFor:(int) position {
    int blankSpot = -1;
    int blankCorner;
    
    switch (position) {
        case 0:
            blankCorner = [self nextBlankCornerFor:0];
            if (blankCorner != -1 && turn != 3) blankSpot = blankCorner;
            else if ([positions[1] intValue] == 0) blankSpot = 1;
            else if ([positions[3] intValue] == 0) blankSpot = 3;
            break;
        case 2:
            blankCorner = [self nextBlankCornerFor:2];
            if (blankCorner != -1 && turn != 3) blankSpot = blankCorner;
            else if ([positions[5] intValue] == 0) blankSpot = 5;
            else if ([positions[1] intValue] == 0) blankSpot = 1;
            break;
        case 8:
            blankCorner = [self nextBlankCornerFor:8];
            if ((blankCorner != -1 && turn != 3) || (blankCorner != -1 && [positions[4] intValue] > 0)) blankSpot = blankCorner;
            else if ([positions[7] intValue] == 0) blankSpot = 7;
            else if ([positions[5] intValue] == 0) blankSpot = 5;
            break;
        case 6:
            blankCorner = [self nextBlankCornerFor:6];
            if (blankCorner != -1 && turn != 3) blankSpot = blankCorner;
            else if ([positions[3] intValue] == 0) blankSpot = 3;
            else if ([positions[7] intValue] == 0) blankSpot = 7;
            break;
        default:
            break;
    }
    
    if (blankSpot == -1) {
        for (int index = 0; index < 9; index++) {
            if ([positions[index] intValue] == 0) {
                blankSpot = index;
                break;
            }
        }
    }
    return blankSpot;
}

/*
 * Method to identify the position on screen if any of the players won and if not, kick off the search for the computer's next move
 * @param position: Position on screen of the player's last movement
 * @return int: The position on screen if available or -1 if not.
 */
-(int)chekWinningPositionWith:(int) position {
    int nextPosition = -1;
    int killingPosition = -1;
    
    switch (position) {
        case 0: {
            if (abs([positions[0] intValue] + [positions[1] intValue] + [positions[2] intValue]) == 13) {
                [self makeWinningLineWith:1];
            } else if (abs([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue]) == 123) {
                [self makeWinningLineWith:4];
            } else if (abs([positions[0] intValue] + [positions[4] intValue] + [positions[8] intValue]) == 1033) {
                [self makeWinningLineWith:7];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[1] intValue] + [positions[2] intValue]) == 3) {
                    nextPosition = 2;
                } else if (([positions[1] intValue] + [positions[2] intValue]) == 9) {
                    nextPosition = 1;
                } else if (([positions[4] intValue] + [positions[8] intValue]) == 33) {
                    nextPosition = 8;
                } else if (([positions[4] intValue] + [positions[8] intValue]) == 999) {
                    nextPosition = 4;
                } else if (([positions[3] intValue] + [positions[6] intValue]) == 11) {
                    nextPosition = 6;
                } else if (([positions[3] intValue] + [positions[6] intValue]) == 111) {
                    nextPosition = 3;
                } else {
                    nextPosition = [self searchBlankSpotFor:0];
                }
            }
        } break;
        case 1: {
            if (abs([positions[0] intValue] + [positions[1] intValue] + [positions[2] intValue]) == 13) {
                [self makeWinningLineWith:1];
            } else if (abs([positions[1] intValue] + [positions[4] intValue] + [positions[7] intValue]) == 369) {
                [self makeWinningLineWith:5];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[0] intValue] + [positions[2] intValue]) == 1) {
                    nextPosition = 2;
                } else if (([positions[0] intValue] + [positions[2] intValue]) == 9) {
                    nextPosition = 0;
                } else if (([positions[4] intValue] + [positions[7] intValue]) == 33) {
                    nextPosition = 7;
                } else if (([positions[4] intValue] + [positions[7] intValue]) == 333) {
                    nextPosition = 4;
                } else {
                    nextPosition = [self searchBlankSpotFor:1];
                }
            }
        } break;
        case 2: {
            if (abs([positions[0] intValue] + [positions[1] intValue] + [positions[2] intValue]) == 13) {
                [self makeWinningLineWith:1];
            } else if (abs([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue]) == 1107) {
                [self makeWinningLineWith:6];
            } else if (abs([positions[2] intValue] + [positions[4] intValue] + [positions[6] intValue]) == 153) {
                [self makeWinningLineWith:8];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[0] intValue] + [positions[1] intValue]) == 1) {
                    nextPosition = 1;
                } else if (([positions[0] intValue] + [positions[1] intValue]) == 3) {
                    nextPosition = 0;
                } else if (([positions[4] intValue] + [positions[6] intValue]) == 33) {
                    nextPosition = 6;
                } else if (([positions[4] intValue] + [positions[6] intValue]) == 111) {
                    nextPosition = 4;
                } else if (([positions[5] intValue] + [positions[8] intValue]) == 99) {
                    nextPosition = 8;
                } else if (([positions[5] intValue] + [positions[8] intValue]) == 999) {
                    nextPosition = 5;
                } else {
                    nextPosition = [self searchBlankSpotFor:2];
                }
            }
        } break;
        case 3: {
            if (abs([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue]) == 123) {
                [self makeWinningLineWith:4];
            } else if (abs([positions[3] intValue] + [positions[4] intValue] + [positions[5] intValue]) == 143) {
                [self makeWinningLineWith:2];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[0] intValue] + [positions[6] intValue]) == 1) {
                    nextPosition = 6;
                } else if (([positions[0] intValue] + [positions[6] intValue]) == 111) {
                    nextPosition = 0;
                } else if (([positions[4] intValue] + [positions[5] intValue]) == 33) {
                    nextPosition = 5;
                } else {
                    nextPosition = [self searchBlankSpotFor:3];
                }
            }
        } break;
        case 5: {
            if (abs([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue]) == 1107) {
                [self makeWinningLineWith:6];
            } else if (abs([positions[3] intValue] + [positions[4] intValue] + [positions[5] intValue]) == 143) {
                [self makeWinningLineWith:2];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[2] intValue] + [positions[8] intValue]) == 9) {
                    nextPosition = 8;
                } else if (([positions[2] intValue] + [positions[8] intValue]) == 999) {
                    nextPosition = 2;
                } else if (([positions[3] intValue] + [positions[4] intValue]) == 33) {
                    nextPosition = 3;
                } else {
                    nextPosition = [self searchBlankSpotFor:5];
                }
            }
        } break;
        case 6: {
            if (abs([positions[0] intValue] + [positions[3] intValue] + [positions[6] intValue]) == 123) {
                [self makeWinningLineWith:4];
            } else if (abs([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue]) == 1443) {
                [self makeWinningLineWith:3];
            } else if (abs([positions[2] intValue] + [positions[4] intValue] + [positions[6] intValue]) == 153) {
                [self makeWinningLineWith:8];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[0] intValue] + [positions[3] intValue]) == 1) {
                    nextPosition = 3;
                } else if (([positions[0] intValue] + [positions[3] intValue]) == 11) {
                    nextPosition = 0;
                } else if (([positions[4] intValue] + [positions[2] intValue]) == 33) {
                    nextPosition = 2;
                } else if (([positions[4] intValue] + [positions[2] intValue]) == 9) {
                    nextPosition = 4;
                } else if (([positions[7] intValue] + [positions[8] intValue]) == 333) {
                    nextPosition = 8;
                } else if (([positions[7] intValue] + [positions[8] intValue]) == 999) {
                    nextPosition = 7;
                } else {
                    nextPosition = [self searchBlankSpotFor:6];
                }
            }
        } break;
        case 7: {
            if (abs([positions[1] intValue] + [positions[4] intValue] + [positions[7] intValue]) == 369) {
                [self makeWinningLineWith:5];
            } else if (abs([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue]) == 1443) {
                [self makeWinningLineWith:3];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[6] intValue] + [positions[8] intValue]) == 111) {
                    nextPosition = 8;
                } else if (([positions[6] intValue] + [positions[8] intValue]) == 999) {
                    nextPosition = 6;
                } else if (([positions[1] intValue] + [positions[4] intValue]) == 33) {
                    nextPosition = 1;
                } else {
                    nextPosition = [self searchBlankSpotFor:7];
                }
            }
        } break;
        case 8: {
            if (abs([positions[2] intValue] + [positions[5] intValue] + [positions[8] intValue]) == 1107) {
                [self makeWinningLineWith:6];
            } else if (abs([positions[6] intValue] + [positions[7] intValue] + [positions[8] intValue]) == 1443) {
                [self makeWinningLineWith:3];
            } else if (abs([positions[0] intValue] + [positions[4] intValue] + [positions[8] intValue]) == 1033) {
                [self makeWinningLineWith:7];
            } else {
                killingPosition = [self checkForKillingMove];
                if (killingPosition != -1) nextPosition = killingPosition;
                else if (([positions[2] intValue] + [positions[5] intValue]) == 9) {
                    nextPosition = 5;
                } else if (([positions[2] intValue] + [positions[5] intValue]) == 99) {
                    nextPosition = 2;
                } else if (([positions[4] intValue] + [positions[0] intValue]) == 33) {
                    nextPosition = 0;
                } else if (([positions[4] intValue] + [positions[0] intValue]) == 1) {
                    nextPosition = 4;
                } else if (([positions[6] intValue] + [positions[7] intValue]) == 333) {
                    nextPosition = 6;
                } else if (([positions[6] intValue] + [positions[7] intValue]) == 111) {
                    nextPosition = 7;
                } else {
                    nextPosition = [self searchBlankSpotFor:8];
                }
            }
        } break;
        default:
            break;
    }
    return nextPosition;
}

@end
