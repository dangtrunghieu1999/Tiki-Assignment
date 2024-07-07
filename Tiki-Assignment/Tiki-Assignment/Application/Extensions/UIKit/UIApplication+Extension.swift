//
//  UIApplication+Extension.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit

extension UIApplication {
    static var currentWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
