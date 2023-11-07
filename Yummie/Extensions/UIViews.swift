//
//  UIViewsExtensions.swift
//  Yummie
//
//  Created by Haytham on 01/11/2023.
//

import UIKit

extension UIView {
    
   @IBInspectable var cornerRadius: CGFloat {
      
       get { return self.cornerRadius }
      
       set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
