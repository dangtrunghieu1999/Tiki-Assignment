//
//  ProductListViewController.swift
//  Tiki-Assignment
//
//  Created by Kai on 05/07/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: BaseViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    // MARK: - Define Variables
    private let viewDidLoadTrigger = PublishSubject<Void>()
    private lazy var adapter: ProductHotSearchsAdapter = {
        let adapter = ProductHotSearchsAdapter()
        return adapter
    }()
    
    var viewModel: ProductListViewModel?

    // MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadTrigger.onNext(())
    }
    
    override func bindingData() {
        super.bindingData()
        
        let input = ProductListViewModel.Input(viewDidload: viewDidLoadTrigger)
        guard let output = self.viewModel?.transform(input: input) else {
            return
        }
        
        output.errorTracker.drive(rx.error).disposed(by: disposeBag)
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
        
        output.products
            .drive(with: self, onNext: { vc, data in
                vc.layout(data)
            }).disposed(by: disposeBag)
    }
    
    override func setupViews() {
        super.setupViews()
        setupProductHotSearchsCollectionView()
    }
    
    private func layout(_ products: [Product]) {
        adapter.setup(productsCollectionView)
        adapter.reloadData(products)
    }
}

// MARK: - Setup View
private extension ProductListViewController {
    func setupProductHotSearchsCollectionView() {
        productsCollectionView.register(ProductCollectionViewCell.reuseIdentifier)
        productsCollectionView.backgroundColor = UIColor.clear
    }
}
