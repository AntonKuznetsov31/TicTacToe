@import Foundation;
@import UIKit;

@interface Game : NSObject

+ (instancetype)sharedInstance;
- (NSString*)putSignAtIndex:(int)i;
- (BOOL)checkForWinSign:(NSString *)sign;
- (void)configNewGame;

@end
