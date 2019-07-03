//
//  JHIGListBaseCellViewModel.m
//    
//
//  Created by   金华 on 2018/11/28.
//  Copyright © 2018   金华. All rights reserved.
//

#import "JHIGListCellComponent.h"
#import "JHIGListSectionComponent.h"

@implementation JHIGListCellComponent

#pragma mark -
#pragma mark - JHIGListCellComponentProtocol

-(Class)cellClass{
    return nil;
}

-(NSString*)cellNibName{
    return @"";
}

-(CGSize)cellSizeWithSectionWidth:(CGFloat)sectionWidth{
    return CGSizeZero;
}

-(void)configure:(UICollectionViewCell*)cell{
    
}

-(void)didSelect:(UICollectionViewCell*)cell{

}


#pragma mark -
#pragma mark - public

-(JHIGListComponentContext*)context{
    return _superComponent.context;
}


-(void)reload:(BOOL)animated{
    [self.superComponent reloadCell:self animated:animated];
}


-(UICollectionView*)collectionView{
    return self.superComponent.collectionView;
}


#pragma mark -
#pragma mark - IGListDiffable

- (nonnull id<NSObject>)diffIdentifier{
    return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    if (object == nil) {
        return NO;
    }
    return object == self;
}


@end
