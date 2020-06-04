//
//  ViewController.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    //Outlets Declaration
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    
    //Variables Declaration
    lazy var refresher: UIRefreshControl = {
        var refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(getMovies), for: .valueChanged)
        return refresher
    }()
    var Movies = [Movie]()
    var currentPage = 1
   
    var isLoading : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movies"
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        tableView.addSubview(activityIndicator)
        tableView.addSubview(refresher)
        refresher.tintColor = .white
        getMovies()
    }
    //MARK:- Get Movies Data
    @objc func getMovies(){
        self.refresher.endRefreshing()
        guard !isLoading else{return}
        isLoading = true
        API.Movies { (error, movies) in
            self.isLoading = false
            if let movies = movies{
                self.Movies = movies
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.currentPage = 1
            }
        }
    }
    //MARK:- Load More Movies When Page ends
    func loadmore(){
        guard !isLoading else{return}
        isLoading = true
        API.Movies(page: currentPage + 1) { (error, movies) in
            self.isLoading = false
            if let movies = movies{
                self.Movies.append(contentsOf: movies)
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.currentPage += 1
            }
        }
    }


}
//MARK:- TableView DataSource Methods:
extension MoviesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        cell.configure(with: Movies[indexPath.row])
        
        return cell
    }
}
//MARK:- TableView Delegate Methods:
extension MoviesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "details"{
            let destination = segue.destination as! MovieDetailsViewController
            if let movieIndex = tableView.indexPathForSelectedRow?.row{
                if let index = Movies[movieIndex].id{
            destination.id = index
                }
            }
        }
    }
    //This Method Is Used In Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.Movies.count
        if indexPath.row == count-1{
            loadmore()
        }
    }

}

