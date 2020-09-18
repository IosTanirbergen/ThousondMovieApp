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
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
        case search
    }
    
      public func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
          let movieURL = baseURL
              .appendingPathComponent("movie")
              .appendingPathComponent(endpoint.rawValue)
          fetchResources(url: movieURL, completion: result)
      }
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        completion(.failure(.invalidEndpoint))
        return
    }
    let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    urlComponents.queryItems = queryItems
        
    guard let url = urlComponents.url else {
        completion(.failure(.invalidEndpoint))
        return
    }
    }
}
