//
//  ProductHotSearchsUseCase.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation
import RxSwift

protocol ProductHotSearchsUseCase {
    func getProductHotSearchs(fileName: String) -> Single<ProductHotSearchs>
}
