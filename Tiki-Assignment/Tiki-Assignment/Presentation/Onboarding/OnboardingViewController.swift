//
//  OnboardingViewController.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit

class OnboardingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCoordinator.showProductList(self.navigationController)
    }
}
