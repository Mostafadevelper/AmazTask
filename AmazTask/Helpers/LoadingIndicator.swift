//

import UIKit


class LoadingIndicator: UIView {
    
    public static let shared = LoadingIndicator()
    public static var restorationIdentifier = "IndicatorView"
    public static var widnow : UIWindow? {
        
        if #available(iOS 13.0, *) {
            return  UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
        }
        return UIApplication.shared.keyWindow
        
    }
    private var indicator : UIActivityIndicatorView =  {
        
        let indicator = UIActivityIndicatorView()
        indicator.color = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.1725490196, alpha: 1)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    func show()  {
        guard let keyWindow = LoadingIndicator.widnow else { return }
        let loaderView = UIView()
        loaderView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        indicator.center = loaderView.center
        loaderView.center = keyWindow.center
        loaderView.accessibilityIdentifier = restorationIdentifier
        loaderView.backgroundColor = .clear
        loaderView.restorationIdentifier = restorationIdentifier
        loaderView.addSubview(indicator)
        keyWindow.addSubview(loaderView)
        keyWindow.bringSubviewToFront(loaderView)
        indicator.startAnimating()
    }
        
    func hide (){
        indicator.stopAnimating()
        guard let keyWindow = LoadingIndicator.widnow else { return }
        for item in keyWindow.subviews
            where item.restorationIdentifier == LoadingIndicator.restorationIdentifier {
                item.removeFromSuperview()
        }
    }
}


