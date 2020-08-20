//
//  Alert+Ex.swift
//  AmazTask
//
//  Created by Mostafa  on 8/18/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit


extension UIViewController {
    
                           func showAlertMessage( title : String = ""  ,
                                                  message : String ,
                                                 handler : ((UIAlertAction) -> Void)? = nil) {
                               
                               let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
                               let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
                               alert.addAction(action)
                               let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                               alert.addAction(cancel)
                               present(alert, animated: true, completion: nil)
                           }

}
