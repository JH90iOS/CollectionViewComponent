//
//  JHIGListBaseSectionViewModel.m
//    
//
//  Created by   金华 on 2018/11/26.
//  Copyright © 2018   金华. All rights reserved.
//

#import "JHIGListSectionComponent.h"
#import "JHIGListSectionController.h"
#import "JHIGListCollectionViewComponent.h"

@interface JHIGListSectionComponent ()

@property (strong,nonatomic)NSMutableArray<JHIGListCellComponent*>* cellComponents;

@end

@implementation JHIGListSectionComponent

#pragma mark -
#pragma mark - init

-(instancetype)init{
    self = [super init];
    if (self) {
        self.cellComponents = [NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithComponents:(NSArray<JHIGListCellComponent*>*)components{
    self = [self init];
    if (self) {
        [self addComponents:components];
    }
    return self;
}



#pragma mark -
#pragma mark - JHIGListSectionComponentProtocol

-(Class)sectionControllerClass{
    return [JHIGListSectionController class];
}


-(UIEdgeInsets)sectionInsets{
    return UIEdgeInsetsZero;
}

-(CGFloat)minimumLineSpacing{
    return 0;
}

-(CGFloat)minimumInteritemSpacing{
    return 0;
}

#pragma mark -
#pragma mark - public

-(UICollectionView*)collectionView{
    return self.superComponent.collectionView;
}

-(JHIGListComponentContext*)context{
    return _superComponent.context;
}


-(void)setComponents:(NSArray<JHIGListCellComponent *> *)components{
    [self.cellComponents removeAllObjects];
    [self addComponents:components];
}


-(NSArray<JHIGListCellComponent*>*)components{
    return self.cellComponents;
}


-(NSInteger)componentsCount{
    return self.cellComponents.count;
}


-(JHIGListCellComponent*)componentOfIndex:(NSInteger)index{
    NSInteger maxIndex = self.cellComponents.count - 1;
    if (index > maxIndex) {
        return nil;
    }
    return [self.cellComponents objectAtIndex:index];
}



-(void)addComponents:(NSArray<JHIGListCellComponent*>*)components{
    
    if (components == nil || components.count == 0) {
        return;
    }
    [self insertComponents:components atIndex:self.cellComponents.count];
}


-(void)insertComponents:(NSArray<JHIGListCellComponent*>*)components atIndex:(NSInteger)index{
    NSInteger count = components.count;
    
    if (count && index <= self.cellComponents.count) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, count)];
        
        for (JHIGListCellComponent* cellComponent in components) {
            cellComponent.superComponent = self;
        }

        [self.cellComponents insertObjects:components atIndexes:indexSet];
        
        [self.sectionController insertCellsAtIndexes:indexSet animated:YES];
    }
}



-(void)reload:(BOOL)animated{
    [self.sectionController reloadSection:animated];
}


-(void)reloadCell:(JHIGListCellComponent*)cellComponent animated:(BOOL)animated{
    
    if (cellComponent == nil) {
        return;
    }
    NSInteger index = [self.cellComponents indexOfObject:cellComponent];
    if (index != NSNotFound) {
        [self.sectionController reloadCellAtIndex:index animated:animated];
    }
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
