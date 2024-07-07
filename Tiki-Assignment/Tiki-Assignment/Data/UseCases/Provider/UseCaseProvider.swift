//
//  UseCaseProvider.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

final class UseCaseProvider: UseCaseProviderProtocol {
    func makeProductHotSearchsUseCase() -> ProductHotSearchsUseCase {
        ProductHotSearchsUseCaseImpl()
    }
}
