//
//  ErrorHandler.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

typealias CallBackClosure = () -> Void

enum ErrorAction: Equatable {
    case toast
    case log
}

protocol ErrorHandler {
    func handle<T>(error: T?, action: ErrorAction?, completion: CallBackClosure?)
    func handle(errorMessage: String, action: ErrorAction?, completion: CallBackClosure?)
}

extension ErrorHandler {
    func handle<T>(error: T?, action: ErrorAction? = .log, completion: CallBackClosure? = nil) {
        
    }
    
    func handle(errorMessage: String, action: ErrorAction?, completion: CallBackClosure?) {
        
    }
}
