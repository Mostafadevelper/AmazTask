//
//  XIB.swift
//  Freejna
//
//  Created by prog_zidane on 7/2/20.
//  Copyright © 2020 Usman Shahid. All rights reserved.
//

import UIKit

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self? {
        
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: "\(self)", bundle: nil).instantiate() as? T
        }
        return instanceFromNib()
    }
    
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
