#import "Game.h"

struct winFields {
    
};

@interface Game()

@property (assign, nonatomic) BOOL firstPlayerMove;
@property (strong, nonatomic) NSMutableArray *playersField;

@end

@implementation Game

+ (instancetype)sharedInstance {
    static Game *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Game alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configNewGame];
    }
    return self;
}

- (void)configNewGame {
    self.firstPlayerMove = YES;
    self.playersField = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        [self.playersField addObject:@""];
    }
}

- (NSString *)putSignAtIndex:(int)i {
    if ([self.playersField[i] isEqualToString:@""]) {
        if (self.firstPlayerMove) {
            self.playersField[i] = @"x";
            self.firstPlayerMove = NO;
            return self.playersField[i];
        } else {
            self.playersField[i] = @"o";
            self.firstPlayerMove = YES;
            return self.playersField[i];
        }
    }
    return @"";
}

- (BOOL)checkForWinSign:(NSString *)sign {
    // проверяем горизонтали
    for (int i = 0; i < 3; i++) {
        if (self.playersField[i * 3] == sign &&
            self.playersField[1 + i * 3] == sign &&
            self.playersField[2 + i * 3] == sign) {
            return YES;
        }
    }
    // проверяем вертикали
    for (int i = 0; i < 3; i++) {
        if (self.playersField[i] == sign &&
            self.playersField[i + 3] == sign &&
            self.playersField[i + 6] == sign) {
            return YES;
        }
    }
    // проверяем диагонали
    for (int i = 0; i < 3; i++) {
        if (self.playersField[0] == sign &&
            self.playersField[4] == sign &&
            self.playersField[8] == sign) {
            return YES;
        } else if (self.playersField[2] == sign &&
                   self.playersField[4] == sign &&
                   self.playersField[6] == sign)
            return YES;
    }
    return NO;
}

@end
