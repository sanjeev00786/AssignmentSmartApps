//
//  HomePageViewModel.swift
//  AssignmentSmartApps
//
//  Created by Sanjeev Mehta on 06/03/22.
//

import UIKit

class HomePageViewModel {
    
    static let shareInstance = HomePageViewModel()
    var homePageArr = [HomePageModel]()
    var filterArr = [HomePageModel]()
    
    func callApi(vc: UIViewController, completion: @escaping(Bool) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        ApiHelper.shareInstance.hitApi(view: vc, method: .get, parm: [:], url: url, isHeader:false, isLoader: true) { json, err in
            if err != nil {
                vc.displayAlert(title: "Warning", msg: "Something went wrong", ok: "Ok")
            } else {
                for i in json["results"].arrayValue {
                    self.homePageArr.append(HomePageModel(i))
                }
                self.filterArr = self.homePageArr
                completion(true)
            }
        }
    }
    
    func getArrCount() -> Int {
        return filterArr.count
    }
    
    func isPosterCell(row: Int) -> Bool {
        if filterArr[row].voteCount < 7 {
            return true
        } else {
            return false
        }
    }
    
    func setPosterCell(cell: PosterCollectionViewCell, row:Int) {
        let arr = filterArr[row]
        if let strUrl = "https://image.tmdb.org/t/p/original\(arr.posterPath)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let imgUrl = URL(string: strUrl) {
            cell.cellImageView.loadImageWithUrl(imgUrl)
      }
        cell.cellImageView.layer.cornerRadius = 8
        cell.descLbl.text = arr.overview
        cell.titleLbl.text = arr.originalTitle
       
    }
    
    func setFullBackdropCell(cell: fullBackDropCollectionViewCell, row:Int) {
        if let strUrl = "https://image.tmdb.org/t/p/original\(filterArr[row].backdropPath)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let imgUrl = URL(string: strUrl) {
            cell.cellImageView.loadImageWithUrl(imgUrl)
            cell.cellImageView.layer.cornerRadius = 8
      }
    }
    
    func deleteItem(item: Int) {
        self.filterArr.remove(at: item)
    }
    
    func filterData(text: String) {
        if text == "" {
            filterArr = homePageArr
        } else {
            filterArr = homePageArr.filter { $0.originalTitle.contains(text) }
        }
    }
    
    func getData(item: Int) -> HomePageModel {
        return homePageArr[item]
    }
}
