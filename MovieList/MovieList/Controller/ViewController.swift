//
//  ViewController.swift
//  MovieList
//
//  Created by ismet sarı on 10.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")

    }

}
