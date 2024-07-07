//
//  XError.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

public enum XError: Error {
    case internalError
    case networkError
    case parsingError
    case noData
}

extension XError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internalError: return "Internal error"
        case .networkError: return "Network error"
        case .parsingError: return "Parsing error"
        case .noData: return "No data"
        }
    }
}
