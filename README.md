# CollectionViewComponent
利用React-Native和Weex中组件的思想，将UICollectionView布局的页面进行组件化，解决复杂页面的扩展性和可维护性问题同时增加组件的复用性。

用户只需要关心数据和Cell样式，不需要进行各种registerNib,registerClass,不需要实现各种 delegat e和 dataSource，用户也不需要再手动缓存高度。

底层使用IGListKit，屏蔽了IGListKit的复杂接口和内部调用，同时将数据驱动扩展到Cell和Header,Footer层级。

使用:

(```)
    JHIGListCollectionViewComponent* viewComponent = [[JHIGListCollectionViewComponent alloc]initWithCollectionView:self.collectionView viewController:self];
    JHIGListSectionComponent* section = [[JHIGListSectionComponent alloc]init];         //section
    JHIGListCellComponent* cell = [[JHIGListCellComponent alloc]init];                  //cell
    JHIGListSupplementaryViewComponent* header = [[JHIGListSupplementaryViewComponent alloc]init];    //header
    JHIGListSupplementaryViewComponent* footer = [[JHIGListSupplementaryViewComponent alloc]init];    //footer
    
    section.components = @[cell];
    section.headerComponent = header;
    section.footerComponent = footer;
    
    viewComponent.sections = @[section];
(```)
