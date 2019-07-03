//
//  JHIGListSupplementaryViewComponent.m
//    
//
//  Created by   金华 on 2019/1/23.
//  Copyright © 2019   金华. All rights reserved.
//

#import "JHIGListSupplementaryViewComponent.h"

@implementation JHIGListSupplementaryViewComponent

#pragma mark -
#pragma mark - JHIGListSupplementaryViewComponentProtocol

-(CGSize)viewSizeWithSectionWidth:(CGFloat)sectionWidth{
    return CGSizeZero;
}

-(void)configure:(UICollectionReusableView*)cell{
    
}

-(Class)viewClass{
    NSAssert(0, @"should override viewClass");
    return [UICollectionReusableView class];
}

-(NSString*)viewNibName{
    NSAssert(0, @"should override viewNibName");
    return nil;
}


@end
