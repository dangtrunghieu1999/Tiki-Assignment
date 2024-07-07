//
//  Product.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

struct Product: Codable {
    let icon: String?
    let name: String?
    
    enum CodingKeys: CodingKey {
        case icon
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    init(icon: String, name: String) {
        self.icon = icon
        self.name = name
    }
}
