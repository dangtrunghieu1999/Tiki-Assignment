//
//  ViewModelTypeProtocol.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

protocol ViewModelTypeProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
