//
//  EndPointType.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var timeoutInterval: Double? { get }
}
