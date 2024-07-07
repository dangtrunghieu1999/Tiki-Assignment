//
//  UIImageView+Extension.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URL?, placeHolder: UIImage?) {
        guard let url = url else {
            self.image = placeHolder
            return
        }
        
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
