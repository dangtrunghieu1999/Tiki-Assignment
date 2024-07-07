//
//  XNetworkManager.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation

typealias XNetworkCompletion<T> = (XResult<T>) -> ()

class XNetworkManager<E: EndPointType> {
    
    let router = Router<E>()
    
    // Serializer
    private let serializer = XSerializer()
    private let completionQueue: DispatchQueue = DispatchQueue.main
    
    func request<T: Codable>(target: E, completion: XNetworkCompletion<T>?) {
        let completionQueue = self.completionQueue
        
        router.request(target) { (data, response, error) in
            if error != nil {
                completionQueue.async { completion?(XResult.failure(XError.networkError)) }
                XLog.print(error?.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if let responseErr = self.handleNetworkResponse(response) {
                    completionQueue.async { completion?(XResult.failure(responseErr)) }
                } else {
                    guard let responseData = data else {
                        completionQueue.async { completion?(XResult.failure(XError.internalError)) }
                        return
                    }
                    
                    // Serialize data
                    guard let parsedData: T = self.serializer.serializeJson(data: responseData) else {
                        completionQueue.async { completion?(XResult.failure(XError.parsingError)) }
                        return
                    }

                    completionQueue.async { completion?(XResult.success(parsedData)) }
                }
            } else {
                completionQueue.async { completion?(XResult.failure(XError.internalError)) }
            }
        }
    }
    
    func requestRaw<T: Codable>(target: E, completion: XNetworkCompletion<T>?) {
        let completionQueue = self.completionQueue
        
        router.request(target) { (data, response, error) in
            if error != nil {
                completionQueue.async { completion?(XResult.failure(XError.networkError)) }
                XLog.print(error?.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if let responseErr = self.handleNetworkResponse(response) {
                    completionQueue.async { completion?(XResult.failure(responseErr)) }
                } else {
                    guard let responseData = data else {
                        completionQueue.async { completion?(XResult.failure(XError.internalError)) }
                        return
                    }
                    
                    // Serialize data
                    guard let parsedData: T = responseData as? T else {
                        completionQueue.async { completion?(XResult.failure(XError.parsingError)) }
                        return
                    }
                    
                    completionQueue.async { completion?(XResult.success(parsedData)) }
                }
            } else {
                completionQueue.async { completion?(XResult.failure(XError.internalError)) }
            }
        }
    }
    
    func requestLocal<T: Codable>(fileName: String, completion: XNetworkCompletion<T>?) {
        getDataFromFile(fileName: fileName, completion: completion)
    }
}

private extension XNetworkManager {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> XError? {
        switch response.statusCode {
        case 200...299: return nil
        default: return XError.internalError
        }
    }
    
    func dataFromJsonFile(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            return NSData(contentsOfFile: path) as Data?
        }
        return nil
    }
    
    func getDataFromFile<T: Codable>(fileName: String, completion: XNetworkCompletion<T>?) {
        if let data = dataFromJsonFile(fileName: fileName) {
            // Serialize data
            guard let parsedData: XResponse<T> = self.serializer.serializeJson(data: data) else {
                completionQueue.async { completion?(XResult.failure(XError.internalError)) }
                return
            }
            
            // Check response status
            guard parsedData.status == 1 else {
                completionQueue.async { completion?(XResult.failure(XError.parsingError)) }
                return
            }
            
            // Check response data
            guard let finalData = parsedData.data else {
                completionQueue.async { completion?(XResult.failure(XError.noData)) }
                return
            }
            
            completionQueue.async { completion?(XResult.success(finalData)) }
        } else {
            completionQueue.async { completion?(XResult.failure(XError.internalError)) }
        }
    }
}
