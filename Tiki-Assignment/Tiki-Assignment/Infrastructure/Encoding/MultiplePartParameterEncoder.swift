//
//  MultiplePartParameterEncoder.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

class MultiplePartParameterEncoder: NSObject {
    public func encode(urlRequest: inout URLRequest, with parameters: MultipartFormData) throws {
        urlRequest.httpBody = try parameters.encode()
        urlRequest.setValue("no-cache", forHTTPHeaderField: "cache-control")
        urlRequest.setValue("multipart/form-data; boundary=\(parameters.boundary)", forHTTPHeaderField: "content-type")
    }
}
