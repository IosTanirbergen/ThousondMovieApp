//
//  Movie.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation

public struct Movie : Codable {
    let id: Int
    let title: String
    let overview: String?
    let releaseData: String?
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let popularity: Float
    let posterPath: String?
    let backdropPath: String? 
}
