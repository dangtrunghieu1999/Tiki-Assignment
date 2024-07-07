//
//  ProductHotSearchsAdapter.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit

class ProductHotSearchsAdapter: BaseCollectionViewAdapter<Product, ProductCollectionViewCell> {
    
    private let kItemSpacing: CGFloat = 8.0
    private var widthItemDefault: CGFloat = 135.0
    private let withImage: CGFloat = 125.0
    private let heightName: CGFloat = 60.0
    private let paddingLeftForText: CGFloat = 21.0
    private let paddingRightForText: CGFloat = 21.0
    
    private let colors: [UIColor] = [
        UIColor(hex: "#16702e"),
        UIColor(hex: "#005a51"),
        UIColor(hex: "#996c00"),
        UIColor(hex: "#5c0a6b"),
        UIColor(hex: "#006d90"),
        UIColor(hex: "#974e06"),
        UIColor(hex: "#99272e"),
        UIColor(hex: "#89221f"),
        UIColor(hex: "#00345d")
    ]

    override func getCell(collectionView: UICollectionView,
                          cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
        let cell = super.getCell(collectionView: collectionView, cellForItemAt: indexPath)
        let color = colors[indexPath.row % colors.count]
        cell.configCell(items[indexPath.row], backgroundColor: color)
        return cell
    }
    
    override func itemSpacing() -> CGFloat {
        return kItemSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, 
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        let widthText = item.name?.widthForTwoLines(font: UIFont.systemFont(ofSize: 14),
                                                    padding: paddingLeftForText + paddingRightForText) ?? 0.0

        let widthItem = max(widthText, widthItemDefault)
        
        return CGSize(width: widthItem, height: collectionView.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: kItemSpacing, bottom: 0, right: kItemSpacing)
    }
    
}
