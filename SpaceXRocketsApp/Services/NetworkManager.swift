//
//  NetworkManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    private let sessionConfiguration = URLSessionConfiguration.default
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func request<T: Decodable>(fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        
        let request = URLRequest(url: url)
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // checking the error
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            // trying to get data
            guard let data = data else { return }
            do {
                let elements = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(elements))
            } catch {
                debugPrint("Could not translate the data to the requested type.")
                completionOnMain(.failure(error))
            }
        }.resume()
    }
}
