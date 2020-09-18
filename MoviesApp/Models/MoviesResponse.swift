import Foundation

public struct MoviesResponse: Codable {

    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}
