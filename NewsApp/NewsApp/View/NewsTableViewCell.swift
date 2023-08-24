//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Балауса Косжанова on 04.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsName: UILabel!
    
    @IBOutlet weak var newsSeen: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
    }
    
}
