//
//  HomeTableCell.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    
    
        var listCellViewModel : HomeCellViewModel? {
            didSet {
                img.kf.setImage(with: URL(string: URLs.base_url + (listCellViewModel?.imageUrl)!))
                nameLB.text = listCellViewModel?.name
                typeLB.text = listCellViewModel?.gender == 2 ? "Male" : "Female"
            }
        }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.masksToBounds = true
    }
    
    //To Make any Uiview in Collection View Cell is circle
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.img.layer.cornerRadius = CGFloat(roundf(Float(self.img.frame.size.height / 2.0)))
        self.img.clipsToBounds = true
        
    }
    
    
    
}
