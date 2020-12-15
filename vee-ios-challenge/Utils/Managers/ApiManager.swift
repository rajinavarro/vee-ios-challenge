//
//  HashGenerator.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    /// Gera chave da API.
    func createAPIKey(ts: String, publicKey: String = APIKeys.publicKey.rawValue, privateKey: String = APIKeys.privateKey.rawValue)
    -> (String){
        
        let initialStringHash = ts + privateKey + publicKey
        let finalHash = initialStringHash.md5
        
        return finalHash
    }
}
