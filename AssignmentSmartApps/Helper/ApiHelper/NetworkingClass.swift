//
//  NetworkingClass.swift
//  Sayara
//
//  Created by SANJEEV on 31/10/20.
//  Copyright © 2020 Sanjeev. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ApiHelper{

    static let shareInstance = ApiHelper()
          
   
    func hitApi(view:UIViewController,method:HTTPMethod,parm:[String:Any],url:String, isHeader:Bool,isLoader:Bool, completion: @escaping(JSON,Error?) -> ()){

        var av = UIView()
        if isLoader{
        av = Loader.start(view: view.view)
        }
        
        if !Reachability.isConnectedToNetwork(){
            av.removeFromSuperview()
            view.displayAlert(title: "Alert!", msg: "No internet connection.", ok: "Ok")
            
            return
        }
        guard let url = URL(string: url) else{return}
            print(url)

        
        Alamofire.request(url, method: method, parameters: parm,encoding: URLEncoding.default).responseJSON { response in
            av.removeFromSuperview()
            switch response.result{
            case .success(let value):
                
                do {
                    let jsonData = try JSON(data: response.data!)
                   
                        completion(jsonData, nil)
                    
                    
                }catch{}
            case .failure(let err):
                print(err)
                
                do {
                    try completion(JSON(data: NSData() as Data), err)
                }catch{
                    completion(JSON.null,err)
                }
            }
    }
        
      }
    
  
}
