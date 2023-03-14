//
//  ApiService.swift
//  BikinMVVM
//
//  Created by Phincon on 13/03/23.
//

import Foundation

/// bikin protocol untuk abstraction
protocol ApiServiceEmployeeProtocol {
    var url: String { get } /// untuk nampung url
    func callApi(completion: @escaping(Employees?) -> Void) /// function untuk handle networking
}

/// implement protocol
struct ApiServiceEmployee: ApiServiceEmployeeProtocol{
    var url: String
    
    /// init url
    init(url: String){
        self.url = url
    }
    
    func callApi(completion: @escaping (Employees?) -> Void) {
        /// buat url dari string
        guard let url = URL(string: self.url) else { return }
        
        /// kalo mau pake if let
        //  if let url = URL(string: self.url){
            /// logicnya disini
        //  }
        
        /// buat UrlSession untuk handle api
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // if let data = data {}
            guard let data = data else { return completion(nil)}

            do { /// bikin decoder, masukin data ke model lewat completion
                let decoder = JSONDecoder()
                let modelData = try decoder.decode(Employees.self, from: data)
                completion(modelData)
            } catch { /// handle kalau parsing datanya eror
                completion(nil)
            }
            
        }.resume()
    }
}
