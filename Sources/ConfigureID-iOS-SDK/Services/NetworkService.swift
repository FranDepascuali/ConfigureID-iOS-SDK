//
//  NetworkService.swift
//  
//
//  Created by Francisco D. on 14/04/2022.
//

import Foundation

// TODO: How will I manage errors?
class NetworkService {
    
    private let session: URLSession
    
    static let shared: NetworkService = NetworkService()
    
    init() {
        // TODO: Check if we want ephemeral, this is to avoid a 304
        session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    }
    
    func executeRequest<ResponseType: Codable>(request: Request, onSuccess: @escaping (ResponseType) -> (), onError: @escaping (ConfigureIDError) -> ()) {
        
        let urlRequest = request.urlRequest()

        guard let urlRequest = urlRequest else {
            onError(.invalidURL)
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                onError(.unknownError(error))
            }
            
            if let data = data {
                do {
                    let decoded: Response<ResponseType> = try Environment.decoder.decode(Response<ResponseType>.self, from: data)
                    onSuccess(decoded.data)
                    return
                } catch {
                    print("0_Error occurred get: \(error)")
                }
                
                do {
                    let decodedError: ServerError = try Environment.decoder.decode(ServerError.self, from: data)
                    onError(.error(
                        status: decodedError.error.status,
                        details: decodedError.error.details)
                    )
                    return
                } catch {
                    // TODO
                    print("Error while trying to get the real error: \(error)")
                }
            }
            
            // If we got here, probably we received a 5xx.
            let response = response as! HTTPURLResponse
            let statusCode = response.statusCode
            onError(
                .error(
                    status: statusCode,
                    details: [HTTPURLResponse.localizedString(forStatusCode: statusCode)]
                )
            )
        }
        
        task.resume()
        
    }
}

struct Response<T: Codable>: Codable {
    let data: T
}

struct ServerError: Codable {
    let error: ServerErrorInner
}

struct ServerErrorInner: Codable {
    let status: Int
    let details: [String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        
        var _error: Error? = nil
        
        var _details: [String] = []
        
        do {
            _details = try values.decode([String].self, forKey: .details)
        } catch {
            _error = error
        }
        
        do {
            _details = [try values.decode(String.self, forKey: .details)]
        } catch {
            
        }
        
        if _details.isEmpty, let _error = _error {
            throw _error
        }
        
        self.details = _details
    }
}
