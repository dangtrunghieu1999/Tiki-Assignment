//
//  ProductCollectionViewCell.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var cardBorderView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameWrapperView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = nil
    }
    
    private func setup() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.numberOfLines = 2
        nameWrapperView.layer.cornerRadius = 10
        nameWrapperView.clipsToBounds = true
        
        cardBorderView.layer.borderWidth = 1
        cardBorderView.layer.borderColor = UIColor.lightGray.cgColor
        cardBorderView.layer.cornerRadius = 10
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
    }
    
    func configCell(_ model: Product, backgroundColor: UIColor) {
        nameLabel.text = model.name
        nameWrapperView.backgroundColor = backgroundColor
        iconImageView.setImage(url: URL(string: (model.icon.orEmpty)),
                               placeHolder: UIImage(named: ""))
        
    }
}
