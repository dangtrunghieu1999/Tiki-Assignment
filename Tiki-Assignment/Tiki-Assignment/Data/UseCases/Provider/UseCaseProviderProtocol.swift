//
//  UseCaseProviderProtocol.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

protocol UseCaseProviderProtocol {
    func makeProductHotSearchsUseCase() -> ProductHotSearchsUseCase
}
