//
//  DetailsCollectionCell.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit
import Kingfisher

class DetailsCollectionCell: UICollectionViewCell {
    
    //MARK:- IBOutlet :-
    @IBOutlet weak var imgSlider: UIImageView!
    
    //MARK:- Variable
    var photoListCellViewModel : DetailsCellViewModel? {
        didSet {
            imgSlider.kf.setImage(with: URL(string: URLs.base_url + (photoListCellViewModel?.imageUrl)!))
        }
    }
}
