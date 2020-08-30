//
//  ActorTableViewCell.swift
//  MovieList
//
//  Created by ismet sarı on 29.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage
class ActorTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var actor: Actor? {
        didSet{
            if let theActor = actor {
                self.nameLabel.text = theActor.name ?? "??"
                self.departmentLabel.text = theActor.department ?? "??"
                self.rateLabel.text = "\(theActor.popularity ?? 0.0)"
                self.posterImageLabel?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(theActor.posterPath ?? "")"), completed: nil)
            }
        }
    }
    
    func configure(_ theActor: Actor) {
        self.actor = theActor
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
