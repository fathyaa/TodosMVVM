//
//  TodosViewController.swift
//  TodosMVVM
//
//  Created by Phincon on 14/03/23.
//

import UIKit

class TodosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: TodosViewModel?
    private var modelTodos: [Todos]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.viewModel = TodosViewModel(urlString: "https://jsonplaceholder.typicode.com/todos", apiService: ApiService())
        
        self.viewModel?.bindTodosData = { todosModel in
            if let model = todosModel {
                self.modelTodos = model
                self.tableView.backgroundColor = .white
            } else {
                self.tableView.backgroundColor = .red
            }
            print("reload data")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "TodosTableViewCell")
    }

}

extension TodosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.modelTodos?.count ?? 0
        print("count ", count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let todo = self.modelTodos?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: "TodosTableViewCell", for: indexPath) as? TodosTableViewCell else { return UITableViewCell() }
        cell.setData(data: todo)
        return cell
    }
}
