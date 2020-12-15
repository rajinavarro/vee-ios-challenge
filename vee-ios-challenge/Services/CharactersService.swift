//
//  CharactersService.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 14/12/20.
//

import Foundation

class CharactersService{
    
    /// Carrega lista de personagens da API Marvel.
    func requestCharacters(offset: Int = 50, completion: @escaping(_ characters: [Character], _ offset: Int) -> () ) {

        let publicKey = APIKeys.publicKey.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)

        let url = CharactersAPIURL.getCharacters.rawValue

        let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)"

        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { (data, error) in

            guard let data = data else { return }

            if error == nil {
                do {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                       let responseDict = responseData as? [ String : Any ],
                       let dataDict = responseDict["data"] as? [ String : Any ],
                       let resultsDict = dataDict["results"] as? [ Any ] {
                        
                        let characters = resultsDict.map { Character(args: $0 as? [String: Any]) }
                        let offset = offset + 50
                            
                        completion(characters, offset)
                    }
                }
            }
        }
    }
}
