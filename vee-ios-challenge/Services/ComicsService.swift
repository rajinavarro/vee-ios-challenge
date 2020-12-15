//
//  ComicsService.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 14/12/20.
//

import Foundation

class ComicsService{
    
    /// Carrega quadrinhos em que personagem aparece.
    func requestComics(characterId: Int, completion: @escaping(_ comics: [Comic]) -> () ) {

        let publicKey = APIKeys.publicKey.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)

        let url = "\(CharactersAPIURL.getCharacters.rawValue)/\(characterId)/comics"

        let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"

        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { (data, error) in

            guard let data = data else { return }

            if error == nil {
                do {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                       let responseDict = responseData as? [ String : Any ],
                       let dataDict = responseDict["data"] as? [ String : Any ],
                       let resultsDict = dataDict["results"] as? [ Any ] {
                        
                        completion( resultsDict.map { Comic(args: $0 as? [String: Any]) }  )

                    }
                }
            }
        }
    }
}
