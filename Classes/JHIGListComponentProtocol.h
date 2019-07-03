//
//  JHIGListComponentProtocol.h
//    
//
//  Created by   JH on 2019/1/23.
//  Copyright © 2019   JH. All rights reserved.
//

#ifndef JHIGListComponentProtocol_h
#define JHIGListComponentProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Section
@protocol JHIGListSectionComponentProtocol <NSObject>

@optional
-(Class)sectionControllerClass;

//UI
-(UIEdgeInsets)sectionInsets;

-(CGFloat)minimumLineSpacing;

-(CGFloat)minimumInteritemSpacing;

@end



//Cell
@protocol JHIGListCellComponentProtocol <NSObject>

@required
-(CGSize)cellSizeWithSectionWidth:(CGFloat)sectionWidth;

-(void)configure:(UICollectionViewCell*)cell;

@optional
-(Class)cellClass;

-(NSString*)cellNibName;

//选择
-(void)didSelect:(UICollectionViewCell*)cell;

//显示
-(void)willDisplayCell:(UICollectionViewCell*)cell;

@end


//Supplementary
@protocol JHIGListSupplementaryViewComponentProtocol <NSObject>

@required
-(CGSize)viewSizeWithSectionWidth:(CGFloat)sectionWidth;

-(void)configure:(UICollectionReusableView*)cell;

@optional
-(Class)viewClass;

-(NSString*)viewNibName;

@end




#endif /* JHIGListComponentProtocol_h */
