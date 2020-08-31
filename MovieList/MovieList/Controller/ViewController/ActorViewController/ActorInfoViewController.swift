//
//  ActorInfoViewController.swift
//  MovieList
//
//  Created by ismet sarı on 31.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class ActorInfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    var t: String = "22"
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = t

        // Do any additional setup after loading the view.
    }
}
