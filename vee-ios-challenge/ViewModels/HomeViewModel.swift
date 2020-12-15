//
//  HomeViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func finishFetchCharacters(characters: [Character], offset: Int)
    func failFetchingCharacters(errorMessage: String)
}

class HomeViewModel {

    weak var delegate: HomeViewModelDelegate?

    /// Carrega lista de personagens da API Marvel.
    func getCharacters(offset: Int = 50) {

        let publicKey = APIKeys.publicKey.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)

        let url = CharactersAPIURL.getCharacters.rawValue

        let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)"

        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { [weak self] (data, error) in

            guard let data = data else { return }

            if error == nil {
                do {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                       let responseDict = responseData as? [ String : Any ],
                       let dataDict = responseDict["data"] as? [ String : Any ],
                       let resultsDict = dataDict["results"] as? [ Any ] {

                        self?.delegate?.finishFetchCharacters(characters: resultsDict.map { Character(args: $0 as? [String: Any]) }, offset: offset)

                    }
                }
            } else {
                self?.delegate?.failFetchingCharacters(errorMessage: error?.description ?? "Falha ao carregar herois")
            }

        }
    }
}
