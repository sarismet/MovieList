//
//  BasicMovieTableViewCell.swift
//  MovieList
//
//  Created by ismet sarı on 31.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage

class BasicMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var knownfor: KnownFor? {
        didSet {
            if let tknown = knownfor {
                movieNameLabel.text = tknown.overview ?? "empty"
                self.posterImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(tknown.posterPath ?? "")"), completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
