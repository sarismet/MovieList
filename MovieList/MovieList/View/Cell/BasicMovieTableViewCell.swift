//
//  BasicMovieTableViewCell.swift
//  MovieList
//
//  Created by ismet sarı on 31.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class BasicMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
