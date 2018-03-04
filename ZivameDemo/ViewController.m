//
//  ViewController.m
//  ZivameDemo
//
//  Created by Tara Singh M C on 02/03/18.
//  Copyright © 2018 Tara Singh M C. All rights reserved.
//

#import "ViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductHeaderCRView.h"
#import "ProductFooterCRView.h"
#import "ProductDetailView.h"

@interface ViewController ()<ProductDetailViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *featuresArray;

@property (weak, nonatomic) ProductDetailView *productDetailView;

@property (assign, nonatomic) NSInteger selectedRow;
@property (assign, nonatomic) BOOL isDetailViewShown;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Setting View Title
    self.navigationItem.title = @"PRODUCT FEATURES";
    
    //Getting features detail from JSON File
    self.featuresArray = [self readFeaturesJsonFile];
    
    //Setting Dummy data for selected product
    self.isDetailViewShown = NO;
    
  
    //Configuring Collection View
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(130, 40);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    self.collectionView.collectionViewLayout = layout;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView reloadData];

    
}

-(void)viewDidLayoutSubviews {
    
    //Darwing border to Feature collectionview
    self.collectionView.clipsToBounds = YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.collectionView.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    

    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.collectionView.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth   = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.masksToBounds = YES;
    borderLayer.fillColor   = [UIColor clearColor].CGColor;
    
    [self.collectionView.layer addSublayer:borderLayer];
    
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [UIColor purpleColor].CGColor;
    rightBorder.borderWidth = 4.0f;
    rightBorder.frame = CGRectMake(-1, -1, 4, CGRectGetHeight(self.collectionView.frame)+2);
    
    [self.collectionView.layer addSublayer:rightBorder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods


- (NSArray *)readFeaturesJsonFile
{
    NSDictionary *featuresDict = [self JSONFromFile];
    NSArray *valuesArray = [featuresDict objectForKey:@"values"];
    return valuesArray;
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Features" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - UICollectionView Datasource and Delegate

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.featuresArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *featureDict = [self.featuresArray objectAtIndex:indexPath.row];
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[featureDict objectForKey:@"name"]];
  
    if ((self.isDetailViewShown == YES) && (self.selectedRow == indexPath.row)) {
        cell.titleLabel.textColor = [UIColor colorWithRed:249.0f/255.0f green:0.0f/255.0f blue:93.0f/255.0f alpha:1.0f];
        
    }else {
        cell.titleLabel.textColor = [UIColor purpleColor];
    }
    
    cell.verticalSeparatorView.backgroundColor = [UIColor purpleColor];
    
    if (((indexPath.row % 2) == 0) && (indexPath.row != (self.featuresArray.count - 1))) {
        cell.verticalSeparatorView.hidden = NO;
    }
    else {
        cell.verticalSeparatorView.hidden = YES;
    }
   

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

     NSDictionary *featureDict = [self.featuresArray objectAtIndex:indexPath.row];

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]};


    CGSize size = [(NSString*)[NSString stringWithFormat:@"%@",[featureDict objectForKey:@"name"]] sizeWithAttributes:attributes];

    return CGSizeMake((collectionView.frame.size.width/2), size.height+10);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isDetailViewShown) {
        // Remove the productDetailView if Detail view shown.
        [self.productDetailView removeFromSuperview];
        self.isDetailViewShown = NO;
    }


    self.selectedRow = indexPath.row;
    self.isDetailViewShown = YES;
    
    NSDictionary *featureDict = [self.featuresArray objectAtIndex:indexPath.row];

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    
    ProductDetailView *productDetailView = [[ProductDetailView alloc] initWithFrame:frame withDescription:[featureDict objectForKey:@"description"]];
    productDetailView.delegate = self;

   [self.view addSubview:productDetailView];
    
    self.productDetailView = productDetailView;

    [collectionView reloadData];
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ProductHeaderCRView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor clearColor];
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        
        ProductFooterCRView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerview.titleLabel.text = @"At Home Bras for weekend lazing and for bedtime support. It is made with feather soft contton fabric to keep you comfortable.";
        footerview.titleLabel.font = [UIFont systemFontOfSize:14];
        footerview.titleLabel.textColor = [UIColor lightGrayColor];
        reusableview = footerview;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
   
        return CGSizeMake(collectionView.frame.size.width, 20.0f);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
    return CGSizeMake(collectionView.frame.size.width, 100.0f);
}

#pragma mark - ProductDetailViewDelegate
-(void)didHideProductDetailView {
    
    // Remove the productDetailView
    [self.productDetailView removeFromSuperview];
    self.isDetailViewShown = NO;
    
    [self.collectionView reloadData];
  
}
@end
