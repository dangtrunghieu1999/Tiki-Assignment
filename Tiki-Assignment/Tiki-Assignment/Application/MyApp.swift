//
//  MyApp.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

class MyApp {
    enum Environment: String {
        case staging
        case production
    }
    
    static let shared = MyApp()
    
    static var environment: Environment {
        // These values are set in their corresponding Targets.
        // See: Target > Build Settings > Other Swift Flags.
#if STAGING
        return .staging
#else
        return .production
#endif
    }
    
    // MARK: Shared
    private var useCaseProvider: UseCaseProviderProtocol!
    
    // MARK: ProductHotSearchs
    private(set) var productHotSearchs: ProductHotSearchsUseCase!
    
    // MARK: Initialization
    init() {
        debugPrint("env: \(MyApp.environment.rawValue)")
    }
    
    func bootstrap() {
        useCaseProvider = UseCaseProvider()
        
        productHotSearchs = useCaseProvider.makeProductHotSearchsUseCase()
        
        setup()
    }
    
}

// MARK: - Setup
extension MyApp {
    private func setup() {
        
    }
}
