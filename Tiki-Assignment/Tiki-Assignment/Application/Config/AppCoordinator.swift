//
//  AppCoordinator.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit

class AppCoordinator {
    static func showProductList(_ nav: UINavigationController?) {
        let vm = ProductListViewModel(productHotSearchs: MyApp.shared.productHotSearchs)
        let vc = ProductListViewController()
        vc.viewModel = vm
        nav?.pushViewController(vc, animated: true)
    }
}
