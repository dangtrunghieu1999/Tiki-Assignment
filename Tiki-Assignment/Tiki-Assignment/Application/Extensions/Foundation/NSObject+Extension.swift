//
//  NSObject+Extension.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

extension NSObject {
    @objc var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
    
    @objc class var reuseIdentifier: String {
        return String(describing: self)
    }
}
