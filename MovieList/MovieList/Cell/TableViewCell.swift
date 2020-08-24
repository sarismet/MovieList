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
    
    @IBAction func likeButtonAction() {
        self.setLikeButton(FavoriMoviesController.shared.bringTheAction(self.theMovie))
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var imagePart: UIImageView!
    
    var movieID: Int = 0
    
    var isPopularCell: Bool = false
    
    var theMovie: Movie {
        
        get {
            if isPopularCell {
                return MovieController.shared.getTheMovie(self.movieID)
            }
            return FavoriMoviesController.shared.getTheFavoriMovie(self.movieID)
        }
    }
    
    func setLikeButton(_ isPressed: Bool ){
        if isPressed {
            if let image = UIImage(named: "favFilled.png") {
                likeButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "star.png") {
                likeButton.setImage(image, for: .normal)
            }
        }
    }
    
    func setPopularCellValue(_ bool:Bool){
        self.isPopularCell = bool
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(_ id: Int) {
        
        self.movieID = id

        self.titleLabel.text = self.theMovie.title
        self.overviewLabel.text = self.theMovie.overview
        self.rateLabel.text = "Rate : \(self.theMovie.rate ?? 0.0)/10"
        self.imagePart?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(self.theMovie.poster_path ?? "")"), completed: nil)
        
        
    }
    
    
}
