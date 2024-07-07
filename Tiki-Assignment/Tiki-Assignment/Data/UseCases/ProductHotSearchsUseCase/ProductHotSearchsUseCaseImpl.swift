//
//  ProductHotSearchsUseCaseImpl.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation
import RxSwift

final class ProductHotSearchsUseCaseImpl: ProductHotSearchsUseCase {
    func getProductHotSearchs(fileName: String) -> Single<ProductHotSearchs> {
        return Single.create { single in
            let manager = XNetworkManager<ProductsEndPoint>()
            manager.requestLocal(fileName: fileName) { (result: XResult<ProductHotSearchs>) in
                switch result {
                case .success(let response):
                    single(.success(response))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
