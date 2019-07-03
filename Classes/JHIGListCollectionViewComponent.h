//
//  JHIGListCollectionViewComponent.h
//    
//
//  Created by   JH on 2019/1/23.
//  Copyright © 2019   JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHIGListSectionComponent.h"
#import "JHIGListComponentContext.h"

@interface JHIGListCollectionViewComponent : NSObject

-(instancetype _Nullable )initWithCollectionView:(UICollectionView*_Nullable)collectionView viewController:(UIViewController*_Nullable)viewController;

@property (weak,nonatomic)UICollectionView* _Nullable collectionView;

@property (strong,nonatomic)NSArray<JHIGListSectionComponent*>* _Nullable sections;

@property (strong,nonatomic)JHIGListComponentContext* _Nullable context;

-(void)addSections:(nullable NSArray<JHIGListSectionComponent*>*)sections;

-(void)insertSections:(NSArray<JHIGListSectionComponent*>* _Nonnull)sections atIndex:(NSInteger)index;

@end
