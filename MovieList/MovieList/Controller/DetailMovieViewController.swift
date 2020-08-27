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
    
    @IBOutlet weak var lastStackView: UIStackView!
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    @IBAction func isPressedButton() {
        if isLiked{
            self.isLiked = false
        }else {
            self.isLiked = true
        }
        
        self.setLikeButton()
        //let _ = FavoriMoviesController.shared.bringTheAction(self.movie)
        if let movie = self.movie {
            self.delegate?.didPressButton(movie,self.indexPath)
        }
        
        // self.isLiked = isLiked == false ? true : false
    }
    
    @IBAction func netflixButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!)
        //burda artık forcelayabilir miyim?
    }
    
    @IBAction func imdbButtonAction(_ sender: Any) {
        UIApplication.shared.open(self.imdbURL ?? URL(string: "https://www.imdb.com/?ref_=nv_home")!)
    }
    
    
    var movie:Movie? 
    
    var indexPath: IndexPath = [0,0]
    
    var details: MovieDetails? {
        
        didSet {
            self.setVariables()
        }
    }
    
    func setLikeButton(){
        if self.isLiked {
            if let image = UIImage(named: "like_button.png") {
                likeButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "star.png") {
                likeButton.setImage(image, for: .normal)
            }
        }
    }
    
    var isLiked: Bool = false
    
    var netflixURL: URL?
    
    var imdbURL: URL?
    
    let imageURLInitial: String = "https://image.tmdb.org/t/p/w500"
    
    let notFoundImage: String = "https://i1.wp.com/saedx.com/blog/wp-content/uploads/2019/01/saedx-blog-featured-70.jpg"
    
    let defaultText: String = "??"
    
    let defaultInt: Int = 999
    
    var movieID: Int = 0
    
    weak var delegate: TableViewCellDelegate?
    
    
    func configure(_ movie: Movie, _ indexPath: IndexPath){
        
        self.indexPath = indexPath
        self.isLiked = FavoriMoviesController.shared.isFavorite(movie)
        self.movieID = movie.id ?? 0
        
        self.movie = movie
        
        if MovieDetailController.sharedMovieDetailController.isPresent(movieID) {
            self.details = MovieDetailController.sharedMovieDetailController.getMovieDetail(movieID)
        }else{
            //self.indicator.startAnimating()
            Network.shared.getDetails(movieID, completion: { (result) in
                DispatchQueue.main.async {
                switch result {
                case .success(let allTheDetails):
                    
                        self.details = allTheDetails
                    
                    
                case .failure(let error):
                    print(error.errorMessage)
                    let dialogMessage = UIAlertController(title: "Error!!!", message: "The system does not response. What do you want to retry?", preferredStyle: .alert)
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                    })
                    // Create Cancel button with action handlder
                    let cancel = UIAlertAction(title: "Re-try", style: .cancel) { (action) -> Void in
                        print("Re-try button tapped")
                        self.configure(movie, indexPath)
                    }
                    //Add OK and Cancel button to an Alert object
                    dialogMessage.addAction(ok)
                    dialogMessage.addAction(cancel)
                    // Present alert message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                    
                }
                    self.indicator.stopAnimating()
                }
            })
        }
        
    }
    
    func setVariables(){
        if let details = self.details {
            

            if let backgroundURL = details.backgroundImage {
                self.backgroundImage.sd_setImage(with: URL(string: "\(self.imageURLInitial)\(backgroundURL)"), completed: nil)
            }
            else{
                self.backgroundImage.sd_setImage(with: URL(string: self.notFoundImage), completed: nil)
            }
            
            
            
            self.titleLabel.text = details.title ?? self.defaultText
            
            
            self.dateLabel.text = details.releaseDate ?? self.defaultText
            
        
            self.runTimeLabel.text = "\(details.runtime ?? self.defaultInt)"
            
            
            self.languageLabel.text = details.language ?? self.defaultText
            
            
            self.rateLabel.text = "\(details.rate ?? Double(self.defaultInt))"
            
            
            if let posterImageUrl = details.posterImage {
                self.mainImage.sd_setImage(with: URL(string: "\(self.imageURLInitial)\(posterImageUrl)"), completed: nil)
            }
            else{
                self.backgroundImage.sd_setImage(with: URL(string: self.notFoundImage), completed: nil)
            }
            
            self.genresStackView.spacing = 11
            for genre in details.genres ?? []{
                let label = UILabel()
                let message = " \(genre.name ?? "") "
                
                label.text = message
                label.numberOfLines = 1
                label.adjustsFontSizeToFitWidth = true
                label.textAlignment = .left
                label.text = message
                label.backgroundColor = UIColor(named: "backgroundColor")
                label.textColor = UIColor(named: "textColor")
                label.layer.borderWidth = 1.0
                label.layer.borderColor = UIColor(named: "textColor")?.cgColor
                label.font = label.font.withSize(17)
                self.genresStackView.addArrangedSubview(label)
            }
            
            
            if let overview = details.overview {
                self.overview.text = overview
            }
            for producer in details.productionCompanies ?? [] {
                let label = UILabel()
                label.backgroundColor = UIColor(named: "backgroundColor")
                label.textColor = UIColor(named: "textColor")
                label.text = "   \(producer.name ?? " ")"
                label.textAlignment = .center
                self.producersStackView.addArrangedSubview(label)
            }
            
            for spokenLanguages in details.spokenLanguages ?? [] {
                let label = UILabel()
                label.backgroundColor = UIColor(named: "backgroundColor")
                label.textColor = UIColor(named: "textColor")
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLikeButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: lastStackView.bottomAnchor).isActive = true
        
        overview.isUserInteractionEnabled = true
        
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(overviewlabelClicked(_:)))
        
        overview.addGestureRecognizer(guestureRecognizer)
        
        
        
    }
    
}
