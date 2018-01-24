#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+TFT.h"
#import "NetworkTest.h"

@interface TestRunningViewController : UIViewController {
    float totalTests;
}

@property (nonatomic, strong) NetworkTest *currentTest;
@property (nonatomic, strong) NSString *testName;
@property (strong, nonatomic) IBOutlet UILabel *runningTestsLabel;
@property (strong, nonatomic) IBOutlet UILabel *testNameLabel;
@property (strong, nonatomic) IBOutlet UIView *animationView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UILabel *etaLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTestLabel;

@end
