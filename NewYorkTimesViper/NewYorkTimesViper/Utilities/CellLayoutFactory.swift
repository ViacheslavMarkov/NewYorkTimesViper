//
//  CellLayoutFactory.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

public protocol CellLayoutConforming {
    associatedtype Item = NSCollectionLayoutItem
    associatedtype Size = NSCollectionLayoutSize
    associatedtype Dimension = NSCollectionLayoutDimension
    associatedtype Group = NSCollectionLayoutGroup
    associatedtype Section = NSCollectionLayoutSection
    associatedtype Spacing = NSCollectionLayoutSpacing
}

public enum CellLayoutFactory: CellLayoutConforming {
    public static func makeFullWidthAndHeightCellLayout(itemWidth: Dimension,
                                                        itemHeight: Dimension) -> Section {
        let itemSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = Item(layoutSize: itemSize)
        
        let groupSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let group = Group.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = Section(group: group)
        
        let headerFooterLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(32)
        )
        var boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem]()
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: .init(x: 0, y: -16)
        )
        
        boundarySupplementaryItems.append(headerView)
        section.boundarySupplementaryItems = boundarySupplementaryItems
        
        return section
    }
    
    public static func makeFullWidthAndHeightWithoutHeaderCellLayout(itemWidth: Dimension,
                                                                     itemHeight: Dimension) -> Section {
        let itemSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = Item(layoutSize: itemSize)
        
        let groupSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let group = Group.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = Section(group: group)
        
        return section
    }
}
