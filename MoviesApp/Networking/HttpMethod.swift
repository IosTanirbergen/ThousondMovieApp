import Foundation

struct Http {
    enum Method: String {
        case get
        case post
        case put
        case patch
        case delete
    }

    enum StatusCode: Int {
        case none = 0
        case succeeded = 200
        case created = 201
        case accepted = 202
        case redirection = 300
        case badRequest = 400
        case unauthorized = 401
        case notFound = 404
        case timedOut = 408
        case serverError = 500

        /// Given the value of status code returns the enum.
        /// Returns generic code if it's not declared
        static func get(value: Int) -> StatusCode {

            if let type = StatusCode(rawValue: value) {
                return type
            }

            return getGeneric(value: value)
        }

        /// Returns generic code status type
        static func getGeneric(value: Int) -> StatusCode {

            switch value {
            case 200..<300: return .succeeded
            case 300..<400: return .redirection
            case 400..<500: return .badRequest
            case 500..<600: return .serverError
            default: return .none
            }
        }
    }
}
