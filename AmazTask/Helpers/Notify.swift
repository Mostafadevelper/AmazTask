








import UIKit
import Foundation

class Notify {
    
    class func toast(text :String,for view : UIView) {
        var style = ToastStyle()
        style.messageColor = .white
        style.messageAlignment = .center
        ToastManager.shared.style = style
        view.makeToast(text, duration: 1.5, position: .bottom)
    }
}

