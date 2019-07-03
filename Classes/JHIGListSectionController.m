//
//  JHIGListSectionController.m
//    
//
//  Created by   JH on 2018/11/28.
//  Copyright © 2018   JH. All rights reserved.
//

#import "JHIGListSectionController.h"
#import "JHIGListSectionComponent.h"

@interface JHIGListSectionController()<IGListSupplementaryViewSource>

@end

@implementation JHIGListSectionController

#pragma mark -
#pragma mark - init

-(instancetype)init{
    self = [super init];
    if (self) {
        self.supplementaryViewSource = self;
    }
    return self;
}


#pragma mark -
#pragma mark - IGListSectionController

- (void)didUpdateToObject:(id)object{
    
    JHIGListSectionComponent* sectionComponent;
    if ([object isKindOfClass:[JHIGListSectionComponent class]]) {
        sectionComponent = (JHIGListSectionComponent*)object;
    }
    
    if (sectionComponent) {
        sectionComponent.sectionController = self;
        self.sectionComponent = sectionComponent;
    }
}


-(UIEdgeInsets)inset{
    return [self.sectionComponent sectionInsets];
}


-(CGFloat)minimumLineSpacing{
    return [self.sectionComponent minimumLineSpacing];
}


-(CGFloat)minimumInteritemSpacing{
    return [self.sectionComponent minimumInteritemSpacing];
}


- (NSInteger)numberOfItems{
    return self.sectionComponent.componentsCount;
}


- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    
    CGSize cellSize = CGSizeZero;
    
    JHIGListCellComponent* cellComponent = [self.sectionComponent componentOfIndex:index];
    if (cellComponent) {
        cellSize = [cellComponent cellSizeWithSectionWidth:[self sectionWidth]];
    }
    return cellSize;
}



- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    UICollectionViewCell* cell;
    
    JHIGListCellComponent* cellComponent = [self.sectionComponent componentOfIndex:index];
    Class cellClass = [cellComponent cellClass];
    if (cellClass) {
        cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    }
    else{
        NSString* cellNibName = [cellComponent cellNibName];
        if (cellNibName) {
            cell = [self.collectionContext dequeueReusableCellWithNibName:cellNibName bundle:nil forSectionController:self atIndex:index];
        }
    }

    [cellComponent configure:cell];
    
    return cell;
}



-(void)didSelectItemAtIndex:(NSInteger)index{
    
    UICollectionViewCell* cell = [self.collectionContext cellForItemAtIndex:index sectionController:self];

    JHIGListCellComponent* cellComponent = [self.sectionComponent componentOfIndex:index];
    [cellComponent didSelect:cell];
}



#pragma mark -
#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds{
    NSMutableArray* kinds = [NSMutableArray array];
    if (self.sectionComponent.headerComponent) {
        [kinds addObject:UICollectionElementKindSectionHeader];
    }
    
    if (self.sectionComponent.footerComponent) {
        [kinds addObject:UICollectionElementKindSectionFooter];
    }
    return kinds;
}


- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index{
    
    JHIGListSupplementaryViewComponent* viewComponent;
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
        viewComponent = self.sectionComponent.headerComponent;
    }
    else{
        viewComponent = self.sectionComponent.footerComponent;
    }
    
    UICollectionReusableView* view;
    
    if (viewComponent) {
        Class viewClass = [viewComponent viewClass];
        if (viewClass) {
            view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:viewClass atIndex:index];
        }
        else{
            NSString* viewNibName = [viewComponent viewNibName];
            view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self nibName:viewNibName bundle:nil atIndex:index];
        }
        
        if (view) {
            [viewComponent configure:view];
        }
    }
    
    if (view == nil) {
        view = [[UICollectionReusableView alloc]init];
    }

    return view;
}


- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index{
    
    JHIGListSupplementaryViewComponent* viewComponent;
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
        viewComponent = self.sectionComponent.headerComponent;
    }
    else{
        viewComponent = self.sectionComponent.footerComponent;
    }
    
    if (viewComponent) {
        return [viewComponent viewSizeWithSectionWidth:[self sectionWidth]];
    }
    else{
        return CGSizeZero;
    }
}


#pragma mark -
#pragma mark - JHIGListBaseSectionViewModelProtocol

-(void)reloadSection:(BOOL)animated{
    
    __weak typeof(self) weakSelf = self;
    [self.collectionContext performBatchAnimated:animated updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
        [batchContext reloadSectionController:weakSelf];
    } completion:nil];    
}


-(void)reloadCellAtIndex:(NSInteger)index animated:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    [self.collectionContext performBatchAnimated:animated updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
        [batchContext reloadInSectionController:weakSelf atIndexes:[NSIndexSet indexSetWithIndex:index]];
    } completion:nil];
}


-(void)insertCellsAtIndexes:(NSIndexSet*)indexes animated:(BOOL)animated{
    
    __weak typeof(self) weakSelf = self;
    [self.collectionContext performBatchAnimated:YES updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
        [batchContext insertInSectionController:weakSelf atIndexes:indexes];
    } completion:nil];
}


#pragma mark -
#pragma mark - private

-(CGFloat)sectionWidth{
    CGSize collectionViewSize = self.collectionContext.containerSize;
    UIEdgeInsets collectionViewInset = self.collectionContext.containerInset;
    UIEdgeInsets sectionInset = self.inset;
    CGFloat sectionWidth = collectionViewSize.width - collectionViewInset.left - collectionViewInset.right - sectionInset.left - sectionInset.right;
    return sectionWidth;
}


@end
