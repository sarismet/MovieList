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
    
    var isLiked: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var runTimeLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var genresStackView: UIStackView!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var moreInfoStackView: UIStackView!
    
    @IBOutlet weak var producersStackView: UIStackView!
    
    @IBOutlet weak var spokenLanguagesStackView: UIStackView!
    
    @IBOutlet weak var netflixButton: UIButton!
    
    @IBOutlet weak var imdbButton: UIButton!
    
    
    @IBAction func netflixButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!)
        //burda artık forcelayabilir miyim?
    }
    
    @IBAction func imdbButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.imdbURL ?? URL(string: "https://www.imdb.com/?ref_=nv_home")!)
    }
    
    
    
    
    var details: MovieDetails? {
        
        didSet {
            self.setVariables()
        }
    }
    
    
    var netflixURL: URL?
    
    var imdbURL: URL?
    
    let imageURLInitial: String = "https://image.tmdb.org/t/p/w500"
    
    var movieID: Int = 0
    
    
    func configure(_ movieID: Int){
        
        self.movieID = movieID
        
        if MovieDetailController.sharedMovieDetailController.isPresent(movieID) {
            self.details = MovieDetailController.sharedMovieDetailController.getMovieDetail(movieID)
        }else{
            Network.shared.getMovieDetail(movieID, completion: { (result) in
                switch result {
                case .success(let allTheDetails):
                    DispatchQueue.main.async {
                        self.details = allTheDetails
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
        
    }
    
    func setVariables(){
        if let details = self.details {
            if let backgroundURL = details.backgroundImage {
                self.backgroundImage.sd_setImage(with: URL(string: "\(self.imageURLInitial)\(backgroundURL)"), completed: nil)
            }
            if let title = details.title {
                self.titleLabel.text = title
            }
            if let date = details.releaseDate {
                self.dateLabel.text = date
            }
            if let runTime = details.runtime {
                self.runTimeLabel.text = "\(runTime)"
            }
            if let lan = details.language {
                self.languageLabel.text = lan
            }
            if let rate = details.rate {
                self.rateLabel.text = "\(rate)"
            }
            if let posterImageUrl = details.posterImage {
                self.mainImage.sd_setImage(with: URL(string: "\(self.imageURLInitial)\(posterImageUrl)"), completed: nil)
            }
            for genre in details.genres ?? []{
                let label = UILabel()
                let message = genre.name
                
                label.text = message
                label.numberOfLines = 1
                label.adjustsFontSizeToFitWidth = true
                
                
                
                label.textAlignment = .left
                label.text = message
                label.textColor = .white
                label.backgroundColor = .black
                
                label.font = label.font.withSize(17)
                label.frame = CGRect(x:0,y:0,width:label.intrinsicContentSize.width+7,height:label.intrinsicContentSize.height+7)
                self.genresStackView.addArrangedSubview(label)
                self.genresStackView.spacing = 7
            }
            if let overview = details.overview {
                self.overview.text = overview
            }
            for producer in details.productionCompanies ?? [] {
                let label = UILabel()
                label.textColor = .white
                label.text = "   \(producer.name ?? " ")"
                label.textAlignment = .center
                self.producersStackView.addArrangedSubview(label)
            }
            
            for spokenLanguages in details.spokenLanguages ?? [] {
                let label = UILabel()
                label.textColor = .white
                label.text = spokenLanguages.name
                label.textAlignment = .center
                self.spokenLanguagesStackView.addArrangedSubview(label)
            }
        }
        
        
    }
    
    @objc func overviewlabelClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieTextViewController.self)) as! MovieTextViewController
        
        vc.setTexts(overview.text ?? " ", self.details?.tagline ?? " ")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: imdbButton.bottomAnchor).isActive = true
        
        overview.isUserInteractionEnabled = true
        
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(overviewlabelClicked(_:)))
        
        overview.addGestureRecognizer(guestureRecognizer)
        
        
        
    }
    
}
