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

    var isPressed: Bool = false
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func like_unlikeButton() {
        if isPressed {
            isPressed = false
            if let image = UIImage(named: "star.png") {
                likeButton.setImage(image, for: .normal)
            }
        }else{
            isPressed = true
            if let image = UIImage(named: "favFilled.png") {
                likeButton.setImage(image, for: .normal)
            }
        }
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var s: UILabel!
    @IBOutlet weak var imagePart: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let image = UIImage(named: "star.png") {
            likeButton.setImage(image, for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(data: PopularMovies?) {
    
        self.titleLabel.text = data?.title
        self.s.text = data?.overview
        self.date.text = "Date : \(data?.release_date ?? "20.2.2020")"
        self.genre.text = "Rate : \(data?.popularity ?? 11.11)"
        self.imagePart?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(data?.poster_path ?? " ")"), completed: nil)
            
        }
        
}
