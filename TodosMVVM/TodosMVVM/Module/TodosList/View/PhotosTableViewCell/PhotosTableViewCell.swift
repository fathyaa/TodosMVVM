//
//  PhotosTableViewCell.swift
//  TodosMVVM
//
//  Created by Adlan Nourindiaz on 15/03/23.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    static let identifier = "PhotosTableViewCell"
    
    @IBOutlet weak var albumIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data: PhotosModel){
        
        albumIdLabel.text = "\(data.albumId)"
        idLabel.text = "\(data.id)"
        titleLabel.text = data.title
        let url = URL(string: data.url)
    
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.photo.image = UIImage(data: data!)
                }
        }
        
    }
}
