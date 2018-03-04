//
//  ProductDetailView.h
//  ZivameDemo
//
//  Created by Tara Singh M C on 04/03/18.
//  Copyright © 2018 Tara Singh M C. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductDetailViewDelegate <NSObject>

@optional

-(void)didHideProductDetailView;

@end

@interface ProductDetailView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDescription:(NSString *)description;

@property (weak, nonatomic) IBOutlet id<ProductDetailViewDelegate> delegate;


@end
