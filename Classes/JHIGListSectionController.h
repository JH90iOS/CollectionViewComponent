//
//  JHIGListSectionController.h
//    
//
//  Created by   金华 on 2018/11/28.
//  Copyright © 2018   金华. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "JHIGListSectionComponent.h"

@interface JHIGListSectionController : IGListSectionController

@property (strong,nonatomic)JHIGListSectionComponent* sectionComponent;

-(void)reloadSection:(BOOL)animated;

-(void)reloadCellAtIndex:(NSInteger)index animated:(BOOL)animated;

-(void)insertCellsAtIndexes:(NSIndexSet*)indexes animated:(BOOL)animated;

@end
