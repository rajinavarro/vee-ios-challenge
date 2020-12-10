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
    
    func createAPIKey(timestamp:String ,privateKey:String,publicKey:String)
    -> (String){
        let initialStringHash = timestamp + privateKey + publicKey
        let finalHash = initialStringHash.md5
        print(finalHash)
        return finalHash
    }
}
