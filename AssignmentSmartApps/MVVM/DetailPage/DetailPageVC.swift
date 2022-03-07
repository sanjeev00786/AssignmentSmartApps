//
//  DetailPageVC.swift
//  AssignmentSmartApps
//
//  Created by Sanjeev Mehta on 07/03/22.
//

import UIKit
import Cosmos

class DetailPageVC: UIViewController {

    @IBOutlet weak var imgVW: ImageLoader!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var overViwLbl: UILabel!
    
    var model: HomePageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    func setData() {
        if let strUrl = "https://image.tmdb.org/t/p/original\(model.backdropPath)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let imgUrl = URL(string: strUrl) {
           imgVW.loadImageWithUrl(imgUrl)
      }
        titleLbl.text = model.originalTitle
        releaseDateLbl.text = "Release Date " + model.releaseDate
        
        ratingView.rating = model.voteAverage
        overViwLbl.text = model.overview
    }
}
