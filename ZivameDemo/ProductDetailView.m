//
//  ProductDetailView.m
//  ZivameDemo
//
//  Created by Tara Singh M C on 04/03/18.
//  Copyright © 2018 Tara Singh M C. All rights reserved.
//

#import "ProductDetailView.h"

@interface ProductDetailView () {
    
    CGFloat originalX;
    CGFloat originalY;
    
}

@property (strong, nonatomic) NSString *productDescription;


@end

@implementation ProductDetailView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
   
    originalX = frame.origin.x;
    originalY = frame.origin.y;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    frame.origin.y +=  25;
    frame.origin.x = 25;
    frame.size.width = width - 50;
    frame.size.height = 200;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withDescription:(NSString *)description
{
    
    originalX = frame.origin.x;
    originalY = frame.origin.y;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    frame.origin.y +=  25;
    frame.origin.x = 25;
    frame.size.width = width - 50;
    frame.size.height = 200.0f;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.productDescription = description;
        [self customInit];
    }
    
    return self;
}


#pragma mark - Helper Methods
-(void)customInit
{
    
    
    self.backgroundColor = [UIColor clearColor];
    
    //Darw arrow shape
    // Create a UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(originalX, 22)];
    [path moveToPoint:CGPointMake(originalX+15, 0)];
    [path addLineToPoint:CGPointMake(originalX+30, 22)];
    [path addLineToPoint:CGPointMake(originalX, 22)];

    //Create a CAShapeLayer that uses that UIBezierPath:
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f] CGColor];
   
    //Add shapeLayer as sublayer inside layer view
    [self.layer addSublayer:shapeLayer];
    
 
    // Add content View
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.layer.cornerRadius = 3.0f;
    contentView.layer.masksToBounds = YES;
    
    
    contentView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self addSubview:contentView];
   
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:contentView
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1.0f
                         constant:0.f]];
    

    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:contentView
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:10.f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:contentView
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0.0f]];
    
    
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:contentView
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:0.0f]];
    
    
    
    
    
        //Close Button
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        closeButton.backgroundColor = [UIColor clearColor];
        closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
        [closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
        [contentView addSubview:closeButton];
    
    
        //Close Top
        [contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:closeButton
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:contentView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:10.0f]];
    
        //Close Leading
        [contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:contentView
                                         attribute:NSLayoutAttributeTrailing
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:closeButton
                                         attribute:NSLayoutAttributeTrailing
                                         multiplier:1.0f
                                         constant:10.0f]];
    
    
        [closeButton addConstraint:[NSLayoutConstraint
                                   constraintWithItem:closeButton
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                   multiplier:1.0f
                                   constant:30.0f]];
    
    
    [closeButton addConstraint:[NSLayoutConstraint
                                constraintWithItem:closeButton
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                constant:30.0f]];
    
    
    //Description
    UILabel *productDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    productDescriptionLabel.text = self.productDescription;
    productDescriptionLabel.textColor = [UIColor colorWithRed:89.0f/255.0f green:89.0f/255.0f blue:89.0f/255.0f alpha:1.0f];
    productDescriptionLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    productDescriptionLabel.numberOfLines = 0;
    
    productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        productDescriptionLabel.backgroundColor = [UIColor clearColor];
    [contentView addSubview:productDescriptionLabel];

    //productDescriptionLabel Top
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:productDescriptionLabel
                                attribute:NSLayoutAttributeTop
                                relatedBy:NSLayoutRelationEqual
                                toItem:closeButton
                                attribute:NSLayoutAttributeBottom
                                multiplier:1.0f
                                constant:10.0f]];
    
    //productDescriptionLabel Trailing
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:contentView
                                attribute:NSLayoutAttributeTrailing
                                relatedBy:NSLayoutRelationEqual
                                toItem:productDescriptionLabel
                                attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                constant:10.0f]];
    
    //productDescriptionLabel Leading
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:productDescriptionLabel
                                attribute:NSLayoutAttributeLeading
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentView
                                attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                constant:10.0f]];
    
    
    
    
    
    //Learn More Button
    UIButton *learnMoreButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [learnMoreButton setTitle:@"LEARN MORE" forState:UIControlStateNormal];
 
    [learnMoreButton setTitleColor:[UIColor colorWithRed:250.0f/255.0f green:50.0f/255.0f blue:127.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    learnMoreButton.titleLabel.font =  [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];

    learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    learnMoreButton.backgroundColor = [UIColor clearColor];
    [contentView addSubview:learnMoreButton];
    
    
    //Learn More Button Top
    [contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:learnMoreButton
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:productDescriptionLabel
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                     constant:10.0f]];
    
    //Learn More Button Leading
    [contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:learnMoreButton
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:contentView
                                     attribute:NSLayoutAttributeLeading
                                     multiplier:1.0f
                                     constant:10.0f]];
  
    
    //Learn More Button Bottom
    [contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:contentView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:learnMoreButton
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                     constant:10.0f]];
    
    
    [learnMoreButton addConstraint:[NSLayoutConstraint
                                constraintWithItem:learnMoreButton
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                constant:50.0f]];
    
    
    [learnMoreButton addConstraint:[NSLayoutConstraint
                                constraintWithItem:learnMoreButton
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                constant:120.0f]];
    

    //matchingButton Button
    UIButton *matchingButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [matchingButton setTitle:@"SEE MATCHING PRODUCTS" forState:UIControlStateNormal];

    [matchingButton setTitleColor:[UIColor colorWithRed:250.0f/255.0f green:50.0f/255.0f blue:127.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    matchingButton.titleLabel.font =  [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    matchingButton.translatesAutoresizingMaskIntoConstraints = NO;

    [contentView addSubview:matchingButton];


    //matchingButton Button Top
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:matchingButton
                                attribute:NSLayoutAttributeTop
                                relatedBy:NSLayoutRelationEqual
                                toItem:productDescriptionLabel
                                attribute:NSLayoutAttributeBottom
                                multiplier:1.0f
                                constant:10.0f]];

    //matchingButtonn Leading
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:matchingButton
                                attribute:NSLayoutAttributeLeading
                                relatedBy:NSLayoutRelationEqual
                                toItem:learnMoreButton
                                attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                constant:10.0f]];

    //matchingButtonn Trailing
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:contentView
                                attribute:NSLayoutAttributeTrailing
                                relatedBy:NSLayoutRelationEqual
                                toItem:matchingButton
                                attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                constant:10.0f]];

    //matchingButton Bottom
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:contentView
                                attribute:NSLayoutAttributeBottom
                                relatedBy:NSLayoutRelationEqual
                                toItem:matchingButton
                                attribute:NSLayoutAttributeBottom
                                multiplier:1.0f
                                constant:10.0f]];


    [matchingButton addConstraint:[NSLayoutConstraint
                                    constraintWithItem:matchingButton
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0f
                                    constant:50.0f]];
    

}


#pragma mark - Button Actions Methods

-(void)closeButtonPressed:(id)sender
{
    
    if([self.delegate respondsToSelector:@selector(didHideProductDetailView)])
    {
        [self.delegate didHideProductDetailView];

    }
}


@end

