//
//  RequestProvider.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import Foundation
import SwiftKeychainWrapper
class AuthorizedRequestProvider {
    var urlString: String
    var httpMethod: String
    var allHTTPHeaderFields: [String: String]?
    var httpBody: Data?
    
    
    init(urlString: String,
         httpMethod: String,
         allHTTPHeaderFields: [String: String]? = nil,
         httpBody: Data? = nil) {
        self.urlString = urlString
        self.httpMethod = httpMethod
        self.allHTTPHeaderFields = allHTTPHeaderFields
        self.httpBody = httpBody
    }
    
    func createRequest() -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            request.allHTTPHeaderFields = allHTTPHeaderFields
        }
        return request
    }
}
class AuthorizedNetworkingService {
    func fetch<T: Decodable>(requestProvider: AuthorizedRequestProvider, completion: ((T)->())?) {
        guard let request = requestProvider.createRequest() else {
            return
        }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let decoder = JSONDecoder()
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            guard let _ = response else {
                return
            }
            
            do {
                let value = try decoder.decode(T.self, from: data)
                completion?(value)
            } catch {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                   //print(JSONString)
                }
                print(error)
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
