//
//  Extensions.swift
//  AssignmentSmartApps
//
//  Created by Sanjeev Mehta on 06/03/22.
//

import UIKit

extension UIView{
    func cardView(){
        
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
        
    }
}

extension UIViewController{
    
    //Default Alert Box
    func displayAlert( title:String,msg: String?, ok: String, okAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
            // alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
