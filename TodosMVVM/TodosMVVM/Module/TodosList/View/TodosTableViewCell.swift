//
//  TodosTableViewCell.swift
//  TodosMVVM
//
//  Created by Phincon on 14/03/23.
//

import UIKit

class TodosTableViewCell: UITableViewCell {

    static let identifier = "TodosTableViewCell"
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusCompletedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: Todos){
        userIdLabel.text = "\(data.userId)"
        titleLabel.text = data.title
        
        if data.completed == true {
            statusCompletedLabel.text = "Completed"
        } else {
            statusCompletedLabel.text = "Not completed yet"
        }
            
    }
}
