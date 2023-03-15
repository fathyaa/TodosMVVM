//
//  ApiService.swift
//  TodosMVVM
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol ApiServiceTodosProtocol {
    var url: String { get }
    func callApi(completion: @escaping([Todos]?) -> Void)
}

protocol ApiServiceProtocol{
    mutating func get(url: URL)
    func callApi<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)

}

struct ApiServiceTodos: ApiServiceTodosProtocol {
    var url: String
    
    init(url: String){
        self.url = url
    }
    
    func callApi(completion: @escaping ([Todos]?) -> Void) {
        guard let url = URL(string: self.url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let successData = data {
                do {
                    let decoder = JSONDecoder()
                    let modelData = try decoder.decode([Todos].self, from: successData)
                    print("model data", modelData)
                    completion(modelData)
                } catch {
                    print("model data error")
                    completion(nil)
                }
            }
            else if let errorMessage = error {
                print("ini error ", errorMessage)
            }
        }.resume()
     }
        
}

struct ApiService : ApiServiceProtocol {
    private var url = URL(string: "")
    mutating func get(url: URL) {
        self.url = url
    }
    
    func callApi<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        guard let url = self.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let modelData =  try JSONDecoder().decode(T.self, from: data)
                    completion(.success(modelData))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
