//
//  PhotosViewModel.swift
//  TodosMVVM
//
//  Created by Adlan Nourindiaz on 15/03/23.
//

import Foundation


protocol PhotosViewProtocol {
    var urlString: String { get }
    var bindPhotosData: (([PhotosModel]?) -> ())? { get set}
    func fetchDataPhotos()
}

class PhotosViewModel: PhotosViewProtocol {
    
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var photoDatas: [PhotosModel]?
    
    var bindPhotosData: (([PhotosModel]?) -> Void)?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchDataPhotos()
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
        return self.photoDatas?.count ?? 0
    }
}
