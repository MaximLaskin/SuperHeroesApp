//
//  NetworkManager.swift
//  SuperHeroes
//
//  Created by Maxim on 16.12.2022.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case superHero = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json"
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchData(completion: @escaping(Result<[Superhero], NetworkError>) -> Void) {
        guard let url = URL(string: Link.superHero.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let superheroes = try JSONDecoder().decode([Superhero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(superheroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async { //обращаемся чтобы асинхронно
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
