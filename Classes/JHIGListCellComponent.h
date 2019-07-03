//
//  JHIGListBaseCellViewModel.h
//    
//
//  Created by   JH on 2018/11/28.
//  Copyright © 2018   JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "JHIGListComponentProtocol.h"
#import "JHIGListComponentContext.h"

@class JHIGListSectionComponent;
@interface JHIGListCellComponent : NSObject<JHIGListCellComponentProtocol,IGListDiffable>

@property (weak,nonatomic)JHIGListSectionComponent* superComponent;

@property (strong,nonatomic)JHIGListComponentContext* context;

@property (strong,nonatomic)UICollectionView* collectionView;

-(void)reload:(BOOL)animated;

@end

