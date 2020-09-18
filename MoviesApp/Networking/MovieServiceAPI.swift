import Foundation

class MovieServiceAPI {

    static let shared = MovieServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "210e2b075f370d9cf11509de665a1272"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()

    enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
        case search
    }

    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }

    public func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        fetchResources(url: movieURL, completion: result)
    }

    public func fetchMovie(movieId: Int, result: @escaping (Result<Movie, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(String(movieId))
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

        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse,
                let responseData = data,
                let object = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let jsonValues = object as? [String: Any] else {
                    return
            }

            switch Http.StatusCode.getGeneric(value: urlResponse.statusCode) {
            case .succeeded:
                do {
                    let values = try self?.jsonDecoder.decode(T.self, from: responseData)
                    completion(.success(values!))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .unauthorized:
                completion(.failure(.apiError))
            default: break
            }
        }.resume()
    }

    public func searchMovies(from endpoint: Endpoint, query: String, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent(endpoint.rawValue)
            .appendingPathComponent("movie")
        fetchSearch(url: movieURL, query: query, completion: result)
    }

    private func fetchSearch<T: Decodable>(url: URL, query: String, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "query", value: query)]

        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }


        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse,
                let responseData = data,
                let object = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let jsonValues = object as? [String: Any] else {
                    return
            }

            switch Http.StatusCode.getGeneric(value: urlResponse.statusCode) {
            case .succeeded:
                do {
                    let values = try self?.jsonDecoder.decode(T.self, from: responseData)
                    completion(.success(values!))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .unauthorized:
                completion(.failure(.apiError))
            default: break
            }
        }.resume()
    }

}
