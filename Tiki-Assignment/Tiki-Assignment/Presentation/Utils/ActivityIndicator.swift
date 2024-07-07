//
//  ActivityIndicator.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import RxSwift
import RxCocoa

public class ActivityIndicator: SharedSequenceConvertibleType {
    
    public typealias Element = Bool
    
    private let _lock = NSRecursiveLock()
    private let _variable = PublishSubject<Bool>()
    private let _loading: SharedSequence<DriverSharingStrategy, Bool>
    public init() {
        _loading = _variable.asDriverOnErrorJustComplete().distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        _lock.lock()
        _variable.onNext(true)
        _lock.unlock()
    }
    
    private func sendStopLoading() {
        _lock.lock()
        _variable.onNext(false)
        _lock.unlock()
    }
    
    public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Element> {
           return _loading
       }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
