#import "ConfigureButton.h"

@implementation ConfigureButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UIColor *defaultTintColor = [UIColor colorWithRGBHexString:color_white alpha:1.0f];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRGBHexString:color_white alpha:1.0f].CGColor;
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor colorWithRGBHexString:color_white alpha:1.0f] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRGBHexString:color_white alpha:1.0f] forState:UIControlStateHighlighted];
    UIImage *backGroundImage = [self createSolidColorImageWithColor:defaultTintColor
                                                            andSize:self.bounds.size];
    [self setBackgroundImage:backGroundImage forState:UIControlStateHighlighted];
}

- (UIImage*)createSolidColorImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
