//
//  MovieDetailsViewController.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate {

    //MARK:- Outlets Declaration
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var downloadCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieURL: UILabel!
    @IBOutlet weak var actorTableView: UITableView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var actorTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var movieImagesScrollView: UIScrollView!
    @IBOutlet weak var movieImagePageController: UIPageControl!
    var activityIndicator = UIActivityIndicatorView()
    //MARK:- Variables Declaration
    var details : Details!
    var actors : [Actor] = []
    var movieImagesURLs : [ImageResource] = []
    var id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails(id: id!)
        addShareButton()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    //MARK:- Add Share Button
    func addShareButton(){
        let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain,target: self, action: #selector(shareMovie))
        navigationItem.rightBarButtonItem = shareButton
    }
    //MARK:- Share Button Action
    @objc func shareMovie(){
        let suggestionText = "I have watched \(details.title ?? "this") movie and i recommend it to you."
        let activityController = UIActivityViewController(activityItems: [suggestionText], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    //MARK:- Get Movie Details Method
 func getMovieDetails(id : Int){
        API.movieDetails(id: id) { (error, details, actors) in
            if let details = details {
                self.details = details
                print(details.imageURLs)
                self.updateUI()
                self.getMovieImages()
        }
           if let actors = actors {
                self.actors = actors
                self.updateUI()
                self.getMovieImages()
            }
        }
    }
    //MARK:- UpdateUI
    func updateUI(){
        //Display Movie Details
        self.movieTitle.text = details?.title
        self.movieGenres.text = details.Genres.joined(separator: ", ")
        self.downloadCount.text = details?.downloads
        self.likesCount.text = details?.likes
        self.movieRating.text = "\(details?.rating ?? "0") / 10"
        self.movieLanguage.text = details?.language
        self.descriptionLabel.text = details?.desciption
        self.movieURL.text = details?.movieURL
        //Activity Indicator
        activityIndicator.color = .white
        self.activityIndicator.stopAnimating()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        //Display Movie Images On ScrollView
        addMovieImagesToScrollView()
        //Display Cast Data
        displayCast()
    }
    //MARK:- Get Movie Images Method
    func getMovieImages(){
        for imageURL in self.details.imageURLs{
            let url = ImageResource(downloadURL: URL(string: imageURL)!)
            movieImagesURLs.append(url)
            
        }
    }
    //MARK:- Display Cast Method
    func displayCast(){
        self.actorTableView.reloadData()
        if self.actors.count >= 0 {
            self.actorTableViewHeight.constant = CGFloat(self.actors.count*90)
        }
        if self.actors.count < 0{
            self.actorTableViewHeight.constant = CGFloat(self.actors.count*0)
            
        }
    }
    
    //MARK:- Add Movie Images To ScrollView
    func addMovieImagesToScrollView(){
        for imageIndex in 0 ..< self.movieImagesURLs.count{
            let movieImage = UIImageView()
     
            movieImage.kf.setImage(with: movieImagesURLs[imageIndex])
        
            movieImage.contentMode = .scaleAspectFit
            let X = self.movieImagesScrollView.frame.width * CGFloat(imageIndex)
            movieImage.frame = CGRect(x: X, y: 0, width: self.movieImagesScrollView.frame.width, height: self.movieImagesScrollView.frame.height)
            self.movieImagesScrollView.contentSize.width = self.movieImagesScrollView.frame.width * CGFloat(imageIndex + 1)
            movieImagesScrollView.addSubview(movieImage)
            }
        //Customize Page Controller
            self.movieImagePageController.numberOfPages = movieImagesURLs.count
            self.movieImagePageController.currentPageIndicatorTintColor = .black
            self.movieImagePageController.pageIndicatorTintColor = .lightGray
        
    }
    //Update ScrollView Current Page
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let imageNumber = self.movieImagesScrollView.contentOffset.x / self.movieImagesScrollView.frame.size.width
        self.movieImagePageController.currentPage = Int(imageNumber)
    }
    //MARK:- Go To Movie
//    @IBAction func goToMovie(_ sender: Any) {
//        performSegue(withIdentifier: "goToMovie", sender: self)
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovie"{
            let destination = segue.destination as! MovieWebViewController
            destination.url = details.movieURL
        }
    }
    
    
}
//MARK:- TableView DataSource Methods
extension MovieDetailsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = actorTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieDetailsTableViewCell
        
        cell.configure(with: actors[indexPath.row])

        return cell
    }
   
    
    
}
