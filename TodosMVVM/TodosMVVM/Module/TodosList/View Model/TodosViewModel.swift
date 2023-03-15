//
//  TodosViewModel.swift
//  TodosMVVM
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol TodosViewProtocol {
    var urlString: String { get }
    var bindTodosData: (([Todos]?) -> ())? { get set}
    func fetchDataTodos()
}

class TodosViewModel: TodosViewProtocol {
//    private let apiService: ApiServiceTodos?
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var data: [Todos]?
    var photoDatas: [PhotosModel]?
    
    var bindTodosData: (([Todos]?) -> Void)?
    var bindPhotosData: (([PhotosModel]?) -> Void)?
    
    
//    init(urlString: String) {
//        self.urlString = urlString
//        self.apiService = ApiServiceTodos(url: self.urlString)
//        fetchDataTodos()
//    }
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchDataTodos()
    }
    
    func fetchDataTodos() {
//        self.apiService?.callApi(completion: { todosData in
//            if let model = todosData {
//                print("list model ", todosData)
//                self.data = model
//                self.bindTodosData?(model)
//            } else {
//                self.bindTodosData?(nil)
//            }
//        })
        self.apiService?.callApi(model: [Todos].self, completion: { response in
            switch response {
            case .success(let success):
                self.bindTodosData?(success)
            case .failure(_):
                self.bindTodosData?(nil)
            }
        })
    }
    
    func fetchDataPhotos() {
        self.apiService?.callApi(model: [PhotosModel].self, completion: { response in
            switch response {
            case .success(let success):
                self.bindPhotosData?(success)
            case .failure(_):
                self.bindPhotosData?(nil)
            }
        })
        
        
    }
    
    
    func numberOfRowsInSection() -> Int {
        return self.data?.count ?? 0
    }
}
