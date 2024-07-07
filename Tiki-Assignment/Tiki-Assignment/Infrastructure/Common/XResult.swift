//
//  XResult.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

enum XResult<T>{
    case success(T)
    case failure(XError)
}

typealias XPagingResult<T: Codable>   = XResult<XPagingData<T>>

