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
    
    func setMovieId(_ movieId: Int){
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
        }else{
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
    
    private func setVariables(_ details: Details){
        
        self.netflixURL = details.netflixURL ?? URL(string: "https://www.netflix.com/tr-en/")!
        self.imdbURL = URL(string: "https://www.imdb.com/title/\(details.imdbID ?? "tt7363104/")")!
        
        self.mainImageURL = "\(self.imageURLInitial)\(details.posterImage ?? "/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")"
        self.imageURL = "\(self.imageURLInitial)\(details.backgroundImage ?? "/fjCezXiQWfGuNf4t7LruKky7kwV.jpg")"
        print("background image \(self.imageURL)")
        
        self.taglineText = details.tagline ?? " "

        mainImage.sd_setImage(with: URL(string: self.mainImageURL), completed: nil)
              
        backgroundImage.sd_setImage(with: URL(string: self.imageURL), completed: nil)
              
        self.titleLabel.text = details.title
        
        let dateYear = details.releaseDate?.components(separatedBy: "-")
        
              
        dateLabel.text = dateYear?[0] //there is no alert or something???
        let (hour,minutes) = details.runtime?.quotientAndRemainder(dividingBy: 60) ?? (0,0)
        runTimeLabel.text = "\(hour) h \(minutes) min"
        languageLabel.text = details.language
        
        for genre in details.genres ?? []{
            let label = UILabel()
            let message = genre.name
            //set the text and style if any.
            label.text = message
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            
            
            
            label.textAlignment = .left
            label.text = message
            label.textColor = .white
            label.backgroundColor = .black
            //label.numberOfLines = 0
            
            label.font = label.font.withSize(17)
            print(label.intrinsicContentSize.width)
            label.frame = CGRect(x:0,y:0,width:label.intrinsicContentSize.width+7,height:label.intrinsicContentSize.height+7)
            self.genresStackView.addArrangedSubview(label)
            self.genresStackView.spacing = 7
        }


              
        rateLabel.text = "\(details.rate ?? 0.0)/10"
              
        overview.text = details.overview
        overview.sizeToFit()
        overview.numberOfLines = 0
        
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

            Network.shared.getMovieDetail(self.movieID , completion: { (result) in
                           switch result {
                           case .success(let details):
                               DispatchQueue.main.async {
                                self.setVariables(details)
                                
                                print(details.genres?[0].name ?? "sss")

                               }
                           case .failure(let error):
                               print(error)
                           }
            })
        

        
        
    }
   
}
