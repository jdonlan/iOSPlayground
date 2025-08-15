import Foundation

protocol LorcanaAPIServiceProtocol {
    func fetchCards() async throws -> [LorcanaCard]
}

class LorcanaAPIService: LorcanaAPIServiceProtocol {
    private let session: URLSession
    private let baseURL = "https://api.lorcana-api.com"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCards() async throws -> [LorcanaCard] {
        let urlString = "\(baseURL)/bulk/cards"
        print("🌐 Fetching Lorcana cards from API...")
        
        guard let url = URL(string: urlString) else {
            throw LorcanaAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30.0
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw LorcanaAPIError.invalidResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                print("❌ API error: HTTP \(httpResponse.statusCode)")
                throw LorcanaAPIError.serverError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            let cards = try decoder.decode([LorcanaCard].self, from: data)
            
            print("✅ Successfully fetched \(cards.count) cards from API")
            return cards
            
        } catch let error as DecodingError {
            print("❌ Failed to decode API response: \(error.localizedDescription)")
            throw LorcanaAPIError.decodingError(error)
        } catch {
            print("❌ Network error: \(error.localizedDescription)")
            throw LorcanaAPIError.networkError(error)
        }
    }
}

enum LorcanaAPIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case networkError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}