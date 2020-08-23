//
//  TableViewCell.swift
//  MovieList
//
//  Created by ismet sarı on 13.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    
    
    
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var imagePart: UIImageView!
    
    func setLikeButton(_ isPressed: Bool ){
        if isPressed {
            if let image = UIImage(named: "favFilled.png") {
                print("burdayımmm")
                likeButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "star.png") {
                likeButton.setImage(image, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(data: Movie) {
        
        self.titleLabel.text = data.title
        self.overviewLabel.text = data.overview
        self.rateLabel.text = "Rate : \(data.rate ?? 0.0)/10"
        self.imagePart?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(data.poster_path ?? "")"), completed: nil)
        
        
    }
    
    
}
