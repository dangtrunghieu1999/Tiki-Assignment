//
//  BaseViewController.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController, ErrorHandler {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        bindingData()
        setupNavigation()
    }
    
    func setupViews() {}
    
    func bindingData() {}
    
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit 😝😝😝")
    }
    
    func showHubLoadingIndicator(in parentView: UIView? = nil,
                                 loadingMessage: String? = nil,
                                 allowsUserInteraction: Bool = false) {
        DispatchQueue.main.async {
            LoadingViewHelper.showLoading(
                in: parentView ?? UIApplication.currentWindow ?? self.view,
                loadingMessage: loadingMessage,
                allowsUserInteraction: allowsUserInteraction)
        }
    }
    
    func dismissHubIndicator() {
        DispatchQueue.main.async {
            LoadingViewHelper.hideLoading()
        }
    }
}

extension Reactive where Base: BaseViewController {
    var isLoading: Binder<Bool> { Binder(base) { $1 ? $0.showHubLoadingIndicator() : $0.dismissHubIndicator() }}
    var error: Binder<(Error, ErrorAction)> {
        Binder(base) { (base: Base, payload: (err: Error, action: ErrorAction)) in
            base.handle(error: payload.err, action: payload.action)
        }
    }
}
