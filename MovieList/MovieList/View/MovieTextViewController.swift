//
//  MovieTextViewController.swift
//  MovieList
//
//  Created by ismet sarı on 19.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit

class MovieTextViewController: UIViewController {
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieText: String = ""
    var taglineText: String = ""
    
    func setTexts (_ movieText: String, _ taglineText: String) {
        self.movieText = "Overview: \n\(movieText)"
        self.taglineText = "\" \(taglineText) \""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        overviewLabel.text = movieText
        taglineLabel.text = taglineText
        taglineLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    

}
