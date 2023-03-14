//
//  ListViewModel.swift
//  BikinMVVM
//
//  Created by Phincon on 13/03/23.
//

import Foundation

protocol ListViewProtocol {
    var urlString: String { get }
    var bindEmployeeData: ((Employees) -> ()) { set get}
    func fetchDataEmployee
}

class ListViewModel: ListViewProtocol{
    private let apiService: ApiServiceEmployee?
    private var url: String
    
    /// digunakan untuk callback, misalkan kalau udah keubah datanya
    var bindEmployeeData: ((Employees?) -> ())?
    
    /// init properties yang diinginkan
    init(url: String){
        self.url = url
        self.apiService = ApiServiceEmployee(url: "https://dummy.restapiexample.com/api/v1/employees")
        
        /// panggil function untuk fetch api data
        fetchDataEmployee()
    }
    
    /// function untuk  manggil dan parsing data dari api
    func fetchDataEmployee(){
        /// Data Employees-nya optional
        self.apiService?.callApi(completion: { Employees in
            if let employees = Employees {
                self.bindEmployeeData?(employees)
            } else {
                self.bindEmployeeData?(nil)
            }
        })
    }
}
