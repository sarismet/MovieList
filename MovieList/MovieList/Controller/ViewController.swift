//
//  ViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var popularView: UIView!
    
    @IBOutlet weak var favoriteView: UIView!
    
    
    @IBOutlet weak var actors: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        
        popularView.layer.cornerRadius = 10
        favoriteView.layer.cornerRadius = 10
        actors.layer.cornerRadius = 10

    }

}
