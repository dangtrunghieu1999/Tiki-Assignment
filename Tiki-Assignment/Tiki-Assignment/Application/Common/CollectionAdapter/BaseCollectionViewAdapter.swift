//
//  BaseCollectionViewAdapter.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import UIKit
import RxCocoa
import RxSwift

protocol CollectionViewAdapterDelegate: AnyObject {
    func didSelectModel(_ item: Any)
}

class BaseCollectionViewAdapter<T, U: UICollectionViewCell>: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var collectionView: UICollectionView?
    var items: [T] = []
    var disposeBag = DisposeBag()

    weak var delegate: CollectionViewAdapterDelegate?
    
    func setup(_ clv: UICollectionView) {
        clv.register(U.reuseIdentifier)
        clv.dataSource = self
        clv.delegate = nil
        clv.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView = clv
    }
    
    func reloadData(_ data: [T]) {
        self.items = data
        collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       return getCell(collectionView: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.collectionView(collectionView, insetForSectionAt: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect(items[indexPath.row])
    }
    
    // MARK: Override at childs
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return items.count
    }
    
    func getCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> U {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: U.reuseIdentifier, for: indexPath) as? U else {
            fatalError("Unable to load \(String(describing: U.self))")
        }
        
       return cell
    }
    
    func itemSpacing() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func itemSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func didSelect(_ item: T) {
        delegate?.didSelectModel(item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
