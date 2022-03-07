//
//  Loader.swift
//  Sayara
//
//  Created by SANJEEV on 31/10/20.
//  Copyright © 2020 Sanjeev. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Loader{
    
    public static func start(view:UIView) -> UIView {
        
        let bgView = UIView()
        bgView.frame = view.frame
        bgView.backgroundColor = .white//UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        print(view.frame.width/2)
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y:0, width: 80, height: 80), type: .lineScale, color:  .black, padding: NVActivityIndicatorView.DEFAULT_PADDING)
        activityIndicator.center.x = bgView.center.x
        activityIndicator.center.y = bgView.center.y
        view.addSubview(bgView)
        bgView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return bgView
    }
}


