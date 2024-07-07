//
//  ProductHotSearchs.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

struct ProductHotSearchs: Codable {
    let items: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([Product].self, forKey: .items)
    }
}
