#import "ViewController.h"
#import "Game.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldViewsArray;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    for (UIView *view in self.fieldViewsArray) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    NSString *nameOfSign = [[NSString alloc] init];
    for (int i = 0; i < self.fieldViewsArray.count; i++) {
        if (gesture.view == self.fieldViewsArray[i]) {
            nameOfSign = [[Game sharedInstance] putSignAtIndex:i];
            UIView *view = [self.fieldViewsArray objectAtIndex:i];
            view.layer.contents = (id)[UIImage imageNamed: nameOfSign].CGImage;
        }
    }
    
    if ([[Game sharedInstance] checkForWinSign: nameOfSign]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ has won!", nameOfSign] message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self clearUI];
        }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        [[Game sharedInstance] configNewGame];
    }
}

- (void) clearUI {
    for (UIView *view in self.fieldViewsArray) {
        view.layer.contents = nil;
    }
}

@end
