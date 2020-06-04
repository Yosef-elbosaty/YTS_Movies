//
//  MovieDetailsTableViewCell.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import Kingfisher


class MovieDetailsTableViewCell: UITableViewCell {

    //Outlets Declaration
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    let noImageFound = "https://img.icons8.com/ios-filled/50/000000/no-image.png"
    override func awakeFromNib() {
        super.awakeFromNib()
        designCustomization()
    }
    
    func designCustomization(){
        self.actorImageView.layer.cornerRadius = self.actorImageView.frame.width / 2
        self.actorImageView.clipsToBounds = true
        
    }
    func configure(with data:Actor){
        self.actorName.text = data.name ?? "Data Unavailable!"
        self.characterName.text = "as: \(data.characterName ?? "Data Unavailable!")"
        let imageURL = URL(string: data.imageURL ?? noImageFound)
        self.actorImageView.kf.setImage(with: imageURL)
        self.selectionStyle = .none
    }

    

}
