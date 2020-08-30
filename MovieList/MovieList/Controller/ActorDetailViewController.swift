//
//  ActorDetailViewController.swift
//  MovieList
//
//  Created by ismet sarı on 30.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

import SDWebImage

class ActorDetailViewController: UIViewController {

    @IBOutlet weak var actorImage: UIImageView!
    @IBAction func didTabSegment(segment: UISegmentedControl) {
    }
    var theActorID: Int = 271110
    var theActor: Actor? {
        didSet {
                    if let actor = theActor {
                self.actorImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(actor.posterPath ?? "")"), completed: nil)
            }
        }
    }
    func configure(){
        self.theActor = ActorController.shared.getTheActor(self.theActorID)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
}
