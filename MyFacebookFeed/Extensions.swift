//
//  Extensions.swift
//  MyFacebookFeed
//
//  Created by Tobi Omotayo on 10/02/2017.
//  Copyright © 2017 Tobi Omotayo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
