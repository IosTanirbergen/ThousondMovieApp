//
//  MovieResponse.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {

    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}
