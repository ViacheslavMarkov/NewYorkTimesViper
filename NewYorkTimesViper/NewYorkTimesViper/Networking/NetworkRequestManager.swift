//
//  NetworkRequestManager.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

final class NetworkRequestManager: NSObject {
    static let shared = NetworkRequestManager()
    
    let session = URLSession(configuration: .default)
    
    private override init() { super.init() }
    
    func call<RequestObject: Encodable, ResponseObject: Decodable> (
        _ api: API<RequestObject, ResponseObject>,
        completion: ((Result<ResponseObject, GenericError>) -> Void)?
    ) async {
        guard let request = api.makeRequest() else {
            DispatchQueue.main.async {
                completion?(.failure(.init(message: "Could not make request.")))
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let response = response as? HTTPURLResponse,
               (400...500).contains(response.statusCode) {
                completion?(.failure(.init(message: "\(response.statusCode)")))
                return
            }

            self.decodeData(data, completion: completion)
        } catch (let error) {
            completion?(.failure(.init(message: error.localizedDescription)))
        }
    }
    
    func decodeData<ResponseObject: Decodable>(
        _ data: Data,
        dateFormatter: DateFormatter = .iso8601Full,
        completion: ((Result<ResponseObject, GenericError>) -> Void)?
    ) {
        var genericError: GenericError?
        do {
            let decoded = try JSONDecoder.decode(
                ResponseObject.self,
                data: data,
                dateFormatter: dateFormatter
            )
            DispatchQueue.main.async {
                completion?(.success(decoded))
            }
            return
        } catch let DecodingError.dataCorrupted(context) {
            genericError = .init(message: "Error: \(context.debugDescription)")
        } catch let DecodingError.keyNotFound(key, context) {
            genericError = .init(
                message: "Key '\(key)' not found: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch let DecodingError.valueNotFound(value, context) {
            genericError = .init(
                message: "Value '\(value)' not found: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch (let DecodingError.typeMismatch(type, context))  {
            genericError = .init(
                message: "Type '\(type)' mismatch: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch {
            genericError = .init(
                message: "Error: \(error.localizedDescription)"
            )
        }
        
        guard let genericError = genericError else {
            assertionFailure("Generic error is nil when it shouldn't be.")
            return
        }
        DispatchQueue.main.async {
            completion?(.failure(genericError))
        }
    }
}
