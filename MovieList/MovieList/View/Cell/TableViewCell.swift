//
//  TableViewCell.swift
//  MovieList
//
//  Created by ismet sarı on 13.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage

protocol TableViewCellDelegate: AnyObject {
    func didPressButton(_ theMovie: Movie, _ indexPath: IndexPath)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!

    @IBAction func likeButtonAction() {
        if let movie = self.movie {
            self.delegate?.didPressButton(movie, self.indexPath)
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var overviewLabel: UILabel!

    @IBOutlet weak var rateLabel: UILabel!

    @IBOutlet weak var imagePart: UIImageView!

    weak var delegate: TableViewCellDelegate?

    var indexPath: IndexPath = [0, 0]

    var isLiked: Bool {
        get {
            if let movie = self.movie {
               return FavoriMoviesController.shared.isFavorite(movie)
            }
            return false
        }
    }

    var movieID: Int = 0

    var movie: Movie? {

        didSet {
            if let theMovie = movie {
                self.movieID = theMovie.id ?? 0
                self.titleLabel.text = theMovie.title
                self.overviewLabel.text = theMovie.overview
                self.rateLabel.text = "Rate : \(theMovie.rate ?? 0.0)/10"
                self.imagePart?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(theMovie.posterPath ?? "")"), completed: nil)
                self.setLikeButton()
            }

        }
    }

    func setLikeButton() {
        if self.isLiked {
            if let image = UIImage(named: "like_button.png") {
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
        //self.titleLabel.numberOfLines = 0
        //self.titleLabel.adjustsFontSizeToFitWidth = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(_ theMovie: Movie, _ indexPath: IndexPath) {
        self.movie = theMovie
        self.indexPath = indexPath
        self.setLikeButton()
        //print("configure is called")
    }

}
