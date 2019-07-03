//
//  JHIGListCollectionViewComponent.m
//    
//
//  Created by   金华 on 2019/1/23.
//  Copyright © 2019   金华. All rights reserved.
//

#import "JHIGListCollectionViewComponent.h"
#import <IGListKit/IGListKit.h>
#import "JHIGListSectionController.h"

@interface JHIGListCollectionViewComponent ()<IGListAdapterDataSource,UICollectionViewDelegate>

@property (strong,nonatomic)NSMutableArray<JHIGListSectionComponent*>* sectionComponents;

@property (weak,nonatomic)UIViewController* viewController;

@property (strong,nonatomic)IGListAdapter* adapter;

@end


@implementation JHIGListCollectionViewComponent

#pragma mark -
#pragma mark - init

-(instancetype)initWithCollectionView:(UICollectionView*)collectionView viewController:(UIViewController*)viewController{
    self = [super init];
    if (self) {
        _sectionComponents = [NSMutableArray array];
        _collectionView = collectionView;
        _viewController = viewController;
        
        _context = [[JHIGListComponentContext alloc]init];
        _context.viewController = viewController;
        
        [self initIGList];
    }
    return self;
}


-(void)initIGList{
    IGListAdapterUpdater* updater = [[IGListAdapterUpdater alloc]init];
    IGListAdapter* adapter = [[IGListAdapter alloc]initWithUpdater:updater viewController:_viewController];
    _adapter = adapter;
    adapter.collectionView = _collectionView;
    adapter.dataSource = self;
    adapter.collectionViewDelegate = self;
}



#pragma mark -
#pragma mark - public

-(void)addSections:(nullable NSArray<JHIGListSectionComponent*>*)sections{
    
    for (JHIGListSectionComponent* sectionComponent in sections) {
        sectionComponent.superComponent = self;
        [_sectionComponents addObject:sectionComponent];
    }
    
    [_adapter reloadDataWithCompletion:nil];
}


-(NSArray<JHIGListSectionComponent*>*)sections{
    return _sectionComponents;
}


-(void)setSections:(NSArray<JHIGListSectionComponent *> *)sections{
    [_sectionComponents removeAllObjects];
    
    for (JHIGListSectionComponent* sectionComponent in sections) {
        sectionComponent.superComponent = self;
        [_sectionComponents addObject:sectionComponent];
    }
    
    [self.adapter reloadDataWithCompletion:nil];
}


-(void)insertSections:(NSArray<JHIGListSectionComponent*> *)sections atIndex:(NSInteger)index{
    NSInteger count = sections.count;
    if (count && index <= _sectionComponents.count) {
        
        for (JHIGListSectionComponent* sectionComponent in sections) {
            sectionComponent.superComponent = self;
        }
        
        NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, count)];
        [self.sectionComponents insertObjects:sections atIndexes:indexSet];
        
        [self.adapter performUpdatesAnimated:NO completion:nil];
    }
}


#pragma mark -
#pragma mark - IGListAdapterDataSource

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    
    return _sectionComponents;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    
    JHIGListSectionComponent* sectionComponent;
    if ([object isKindOfClass:[JHIGListSectionComponent class]]) {
        sectionComponent = (JHIGListSectionComponent*)object;
    }
    
    if (sectionComponent) {
        Class sectionControllerClass = [sectionComponent sectionControllerClass];
        return [[sectionControllerClass alloc]init];
    }

    return [[JHIGListSectionController alloc]init];
}



- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return [UIView new];
}


#pragma mark -
#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    JHIGListCellComponent* cellComponent = [self cellComponent:indexPath];
    if ([cellComponent respondsToSelector:@selector(willDisplayCell:)]) {
        [cellComponent willDisplayCell:cell];
    }
}



#pragma mark -
#pragma mark - private

- (JHIGListCellComponent *)cellComponent:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSAssert([self.sectionComponents count] > section && section >= 0, @"sections overflow");
    JHIGListSectionComponent *sectionComponent = [self.sectionComponents count] > section && section >= 0 ? self.sectionComponents[section] : nil;
    NSAssert([sectionComponent.components count] > row && row >= 0, @"cell overflow");
    JHIGListCellComponent *cellComponent = [sectionComponent.components count] > row && row >= 0 ? sectionComponent.components[row] : nil;
    return cellComponent;
}



@end
