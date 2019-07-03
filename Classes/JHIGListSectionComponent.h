//
//  JHIGListBaseSectionViewModel.h
//    
//
//  Created by   金华 on 2018/11/26.
//  Copyright © 2018   金华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "JHIGListCellComponent.h"
#import "JHIGListSupplementaryViewComponent.h"
#import "JHIGListComponentProtocol.h"
#import "JHIGListComponentContext.h"

@class JHIGListSectionController;
@class JHIGListCollectionViewComponent;

@interface JHIGListSectionComponent : NSObject<JHIGListSectionComponentProtocol,IGListDiffable>

-(instancetype)initWithComponents:(NSArray<JHIGListCellComponent*>*)components;

@property (strong,nonatomic)UICollectionView* collectionView;

@property (weak,nonatomic)JHIGListCollectionViewComponent* superComponent;

@property (weak,nonatomic)JHIGListSectionController* sectionController;

@property (strong,nonatomic)JHIGListSupplementaryViewComponent* headerComponent;

@property (strong,nonatomic)JHIGListSupplementaryViewComponent* footerComponent;

@property (strong,nonatomic)JHIGListComponentContext* context;

@property (strong,nonatomic)NSArray<JHIGListCellComponent*>* components;

-(NSInteger)componentsCount;

-(JHIGListCellComponent*)componentOfIndex:(NSInteger)index;

-(void)addComponents:(NSArray<JHIGListCellComponent*>*)components;

-(void)insertComponents:(NSArray<JHIGListCellComponent*>*)components atIndex:(NSInteger)index;

-(void)reload:(BOOL)animated;

-(void)reloadCell:(JHIGListCellComponent*)cellComponent animated:(BOOL)animated;

@end

