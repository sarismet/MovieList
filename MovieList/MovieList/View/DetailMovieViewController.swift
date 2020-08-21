//
//  DetailMovieViewController.swift
//  MovieList
//
//  Created by ismet sarı on 16.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {

    var isPressed: Bool = false

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var mainImage: UIImageView!

    @IBOutlet weak var taglineLabel: UILabel!

    @IBOutlet weak var overview: UILabel!

    @IBOutlet weak var netflixButton: UIButton!
    @IBOutlet weak var imdbButton: UIButton!

    @IBOutlet weak var genresStackView: UIStackView!

    private var movieID: Int = 547016

    func getMovieId() -> Int {
        return self.movieID
    }

    func setMovieId(_ movieId: Int) {
        print("movie id was \(self.movieID)")
        self.movieID = movieId
        print("movie id is now \(self.movieID)")
    }
    var netflixURL: URL?
    var imdbURL: URL?
    var imageURLInitial: String = "https://image.tmdb.org/t/p/w500"

    var imageURL: String = "/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"
    var mainImageURL: String = "/fjCezXiQWfGuNf4t7LruKky7kwV.jpg"

    @IBAction func like_unlikeButton() {
        if isPressed {
            isPressed = false
            if let image = UIImage(named: "unlike_button.png") {
                likeButton.setImage(image, for: .normal)
            }
        } else {
            isPressed = true
            if let image = UIImage(named: "like_button.png") {
                likeButton.setImage(image, for: .normal)
            }
        }

    }

    @IBAction func netflixButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!)
        //burda artık forcelayabilir miyim?
    }

    @IBAction func imdbButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.imdbURL ?? URL(string: "https://www.imdb.com/?ref_=nv_home")!)
    }
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    @IBOutlet weak var lastStackView: UIStackView!

    @IBOutlet weak var producersStackView: UIStackView!

    @IBOutlet weak var spokenLanguagesStackView: UIStackView!

    var taglineText: String = ""

    @objc func overviewlabelClicked(_ sender: Any) {
        print("UILabel clicked")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieTextViewController.self)) as! MovieTextViewController

        print(overview.text ?? " ")
        print(taglineText)

        vc.setTexts(overview.text ?? " ", taglineText)
        //vc.overviewLabel.text = overview.text ?? " "
        //vc.taglineLabel.text = taglineText
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: lastStackView.bottomAnchor).isActive = true

                overview.isUserInteractionEnabled = true

        // Create and add the Gesture Recognizer
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(overviewlabelClicked(_:)))
        overview.addGestureRecognizer(guestureRecognizer)

    }

}
