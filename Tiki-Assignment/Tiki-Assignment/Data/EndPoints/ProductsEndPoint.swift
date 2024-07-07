//
//  ProductsEndPoint.swift
//  Tiki-Assignment
//
//  Created by Kai on 07/07/2024.
//

import Foundation

public enum ProductsEndPoint {
    case getProductHotSearchs
}

extension ProductsEndPoint: EndPointType {
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .getProductHotSearchs:
            return "/getProductHotSearchs"
        }
    }
    
    public var headers: HTTPHeaders? { nil }
    
    public var timeoutInterval: Double? {
        return 30.0
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .getProductHotSearchs:
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: nil
            )
        }
    }
}
