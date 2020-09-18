//
//  MovieAPi.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation

class MovieSeviceAPI {
    
    static let shared = MovieSeviceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURl = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "210e2b075f370d9cf11509de665a1272"
    private let jsonDecoder: JSONDecoder = {
           let jsonDecoder = JSONDecoder()
           jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-mm-dd"
           jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
           return jsonDecoder
       }()
    
}
