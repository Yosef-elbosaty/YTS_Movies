//
//  MoviesTableViewCell.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    //Outlets Declaration
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
   
       let noImageFound = "https://img.icons8.com/ios-filled/50/000000/no-image.png"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCustomization()
    }

    func designCustomization(){
        cellBackgroundView.layer.cornerRadius = 20
        cellBackgroundView.layer.borderColor = UIColor(red: 42.0/255.0, green: 196.0/255.0, blue: 68.0/255.0, alpha: 1).cgColor
        cellBackgroundView.layer.borderWidth = 3
        cellBackgroundView.clipsToBounds = true
        
    }
    
    func configure(with data : Movie){
        self.movieTitle.text = data.title
        self.movieGenre.text = data.Genres.joined(separator: ", ")
        self.movieRating.text = "⭐️ \(data.rating ?? "0") / 10"
        let imageURl = URL(string: data.imageURL ?? noImageFound)
        self.movieImage.kf.setImage(with: imageURl)
        self.selectionStyle = .none
    }
    


}
