//
//  ActorDetailViewController.swift
//  MovieList
//
//  Created by ismet sarı on 30.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ActorDetailViewController: UIViewController {

    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
        }
    }
    var theActorID: Int = 271110
    var theActor: Actor? {
        didSet {
            if let actor = theActor {
                self.actorImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(actor.posterPath ?? "")"), completed: nil)
            }
        }
    }
    private func configure() {
        self.theActor = ActorController.shared.getTheActor(self.theActorID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "knownForSeque"{
            let destVC = segue.destination as! ActorKnownForViewController
            destVC.actorID = self.theActor?.id ?? 2263933
        }
        else {
            let destVC = segue.destination as! ActorInfoViewController
            destVC.t = "This person act in good faith"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configure()
        firstView.alpha = 1
        secondView.alpha = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
