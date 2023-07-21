//
//  API.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

class API<RequestObject: Encodable, ResponseObject: Decodable>: NSObject {
    private let requestObject: RequestObject
    
    init(requestObject: RequestObject) {
        self.requestObject = requestObject
        super.init()
    }
    
    func makeBaseURL() -> URL? {
        URL(string: BaseURL.baseURLString)
    }
    
    func makePathComponent() -> String {
        ""
    }
    
    func makeMethodType() -> HTTPMethodType {
        .get
    }
    
    func makeDateFormatter() -> DateFormatter {
        .iso8601Full
    }
    
    func makeHeaders() -> [String: String]? {
        [
            "Content-Type": "application/json"
        ]
    }
    
    func makeQueryItems() -> [URLQueryItem]? {
        nil
    }
    
    func makeRequestBody() -> Data? {
        switch requestObject {
        case is EmptyRequest:
            return nil
        default:
            return try? JSONEncoder().encode(requestObject)
        }
    }
    
    func makeRequest() -> URLRequest? {
        let pathComponent = makePathComponent()
        guard let completeURL = makeBaseURL()?.appendingPathComponent(pathComponent) else {
            assertionFailure("completeURL for API is nil.")
            return nil
        }
        
        var urlComponents = URLComponents(url: completeURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = makeQueryItems()
        
        guard let url = urlComponents?.url else {
            assertionFailure("URL for API is nil.")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = makeMethodType().rawValue
        request.httpBody = makeRequestBody()
        
        let headers = makeHeaders()
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        return request
    }
}
