import Foundation

public struct Movie: Codable {

    let id: Int
    let title: String
    let overview: String?
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let popularity: Float
    let posterPath: String?
    let backdropPath: String?
}
