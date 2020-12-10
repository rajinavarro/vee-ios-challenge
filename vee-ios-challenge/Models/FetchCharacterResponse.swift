//
//  FetchCharacterResponse.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

// MARK: - Welcome
struct CharactersResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String?
    let data: DataClass
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name, resultDescription: String?
    let modified: String
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}
// MARK: - Comics
struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
}

// MARK: - URLElement
struct URLElement: Codable {
    let url: String?
}
