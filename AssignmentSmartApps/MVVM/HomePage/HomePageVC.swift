//
//  ViewController.swift
//  AssignmentSmartApps
//
//  Created by Sanjeev Mehta on 06/03/22.
//

import UIKit

class HomePageVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchview: UISearchBar!
    
    let vm = HomePageViewModel.shareInstance
    var deleteIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(longPressGesture)
        searchview.delegate = self
        callApi()
    }
   
    func callApi () {
        vm.callApi(vc: self) { result in
            if result {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: collectionView)
            if let index = collectionView.indexPathForItem(at: touchPoint) {
                print(index)
                self.deleteIndex = index.item
                openAlert()
            }
        }
    }
    
    func openAlert(){
        let alert = UIAlertController(title: "Smart Apps", message: "Are you sure to delete it?", preferredStyle: .actionSheet)
        
        let deleteActn = UIAlertAction(title: "Delete", style: .destructive, handler: deleteRow(actn:))
        let cancelActn = UIAlertAction(title: "Cancel", style: .cancel, handler: onClickCancel(actn:))
        
        alert.addAction(deleteActn)
        alert.addAction(cancelActn)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.width / 2.0, y: self.view.bounds.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated:true)
        
    }
    
    func deleteRow(actn: UIAlertAction) -> Void {
        collectionView.performBatchUpdates({
            vm.deleteItem(item: deleteIndex)
        }, completion: nil)
        
    }
    
    func onClickCancel(actn: UIAlertAction) -> Void {
        deleteIndex = 0
    }
    
}

//MARK:- UICollection View Methods
extension HomePageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getArrCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if vm.isPosterCell(row: indexPath.item) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
            vm.setPosterCell(cell: cell, row: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fullBackDropCollectionViewCell", for: indexPath) as! fullBackDropCollectionViewCell
            vm.setFullBackdropCell(cell: cell, row: indexPath.row)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVC") as! DetailPageVC
        vc.model = vm.getData(item: indexPath.item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    
}

//MARK:- Seaarch Bar Methods
extension HomePageVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        collectionView.performBatchUpdates({
            vm.filterData(text: searchText)
        }, completion: nil)
    }
    
}
