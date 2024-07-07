//
//  NetworkLogger.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        let urlAsString = request.url?.absoluteString ?? ""
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let cURL = request.cURLDescription

        logDivider()
        
        print("\(method) '\(urlAsString)':")
        print("cURL:\n\(cURL)")
    }
    
    static func log(
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?,
        route: EndPointType
    ) {
        logDivider()
        
        guard error == nil else {
            logError(error: error, route: route)
            return
        }
        
        guard let response = response else {
            logError(errorMessage: "Invalid response", route: route)
            return
        }
        
        print("\(String(response.statusCode)) '\(route.requestURL)':")
        
        logHeaders(headers: response.allHeaderFields)
        
        if let data = data {
            print("Body:\n\(data.prettyPrintedJSONString)")
        }
    }
}

// MARK: - Utils
private extension NetworkLogger {
    static func logDivider() {
        print("---------------------------------------------------------------")
    }
    
    static func logHeaders(headers: [AnyHashable : Any]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key): \(value)")
        }
        print("]")
    }
    
    
    static func logError(
        error: Error? = nil,
        errorMessage: String? = nil,
        route: EndPointType
    ) {
        if let error = error {
            print("[Error] \(route.httpMethod.rawValue) '\(route.requestURL): \(error)")
        } else if let errorMessage = errorMessage {
            print("[Error] \(route.httpMethod.rawValue) '\(route.requestURL): \(errorMessage)")
        }
    }
}

fileprivate extension URLRequest {
    var cURLDescription: String {
        guard
            let url = url,
            let method = httpMethod
        else { return "$ curl command could not be created" }

        var components = ["$ curl -v"]

        components.append("-X \(method)")

        var headers = [String: String]()

        for header in (allHTTPHeaderFields ?? [:]) where header.key != "Cookie" {
            headers[header.key] = header.value
        }

        for header in headers {
            let escapedValue = header.value.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("-H \"\(header.key): \(escapedValue)\"")
        }

        if let httpBodyData = httpBody {
            components.append("-d \"\(httpBodyData.prettyPrintedJSONString)\"")
        }

        components.append("\"\(url.absoluteString)\"")

        return components.joined(separator: " \\\n\t")
    }
}

fileprivate extension EndPointType {
    var requestURL: String { baseURL.absoluteString + path }
}
