//
//  ProductListViewModel.swift
//  Tiki-Assignment
//
//  Created by Kai on 05/07/2024.
//

import Foundation
import RxSwift
import RxCocoa

class ProductListViewModel: BaseViewModel {
    private let productHotSearchs: ProductHotSearchsUseCase
    private let activityTracker = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    init(productHotSearchs: ProductHotSearchsUseCase) {
        self.productHotSearchs = productHotSearchs
    }
}

// MARK: - ViewModelTypeProtocol
extension ProductListViewModel: ViewModelTypeProtocol {
    
    struct Input {
        let viewDidload: Observable<Void>
    }
    
    struct Output {
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
        let products: Driver<[Product]>
    }
    
    func transform(input: Input) -> Output {
        let products = input.viewDidload
            .withUnretained(self)
            .flatMapLatest { vm, _ in
                vm.productHotSearchs.getProductHotSearchs(fileName: "hot_find_key_products")
                    .trackActivity(vm.activityTracker)
                    .trackError(vm.errorTracker)
                    .catchErrorJustComplete()
            }
            .compactMap(\.items)
        
        return Output(
            loadingIndicator: activityTracker,
            errorTracker: errorTracker,
            products: products.asDriverOnErrorJustComplete()
        )
    }
}
