//
//  ImageTableVC.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableVC: UITableViewController {
    
    //MARK:- IBOutlet :-
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet weak var optionBtn: UIButton!
    
    //MARK:- Variable & Constants:-
    
    var image = ""
    
    //MARK:- Life Cycle :-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupGesturee()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipeImage.kf.setImage(with: URL(string: image))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.2) {
            self.closeButton.alpha = 0
            self.optionBtn.alpha = 0
        }
    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.contentInset = UIEdgeInsets.zero
        NSLayoutConstraint.activate([
            recipeImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        ])
    }
    
    func setupGesturee(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(saveImage))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc  func saveImage() {
        
        showAlertMessage(title: Messages.alertTitle , message: Messages.alertMessage) { (action) in
            guard let image = self.recipeImage.image else {return}
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.ImageSucces), nil)
        }
        
    }
    
    @objc func ImageSucces(_ image : UIImage , didFinishsavingWithError err : Error? , contextInfo : UnsafeRawPointer) {
        if let err = err {
            Notify.toast(text:Messages.erorr + err.localizedDescription, for: self.view)
        }else { Notify.toast(text: Messages.saved , for: self.view) }
    }
    
    //MARK:- This To Show Alert Option
    @IBAction func moreOptionPressed(_ sender: Any) {
        saveImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension ImageTableVC {
    @IBAction func dismissAction() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate

extension ImageTableVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}







