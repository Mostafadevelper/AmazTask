



//

import Foundation
import UIKit

extension UISearchBar {
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        return (subViews.filter { $0 is UITextField }).first as? UITextField
    }
    
    func setCenteredPlaceHolder(){
        let searchBarWidth = self.frame.width
        let placeHolderWidth = textField?.attributedPlaceholder?.size().width
        let offsetIconToPlaceholder: CGFloat = 8
        let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - offsetIconToPlaceholder), vertical: 0)
        self.setPositionAdjustment(offset, for: .search)
    }
    
    func setup(placeHolder:String){
        textField?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5718107877)
        textField?.tintColor = #colorLiteral(red: 0.06274509804, green: 0.5137254902, blue: 0.5058823529, alpha: 1)
        textField?.textColor = .black
        layer.cornerRadius = 6
        self.semanticContentAttribute = .forceLeftToRight
        self.textField?.semanticContentAttribute = .forceLeftToRight
        clipsToBounds = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        tintColor = #colorLiteral(red: 0.06274509804, green: 0.5137254902, blue: 0.5058823529, alpha: 1)
    }
}



