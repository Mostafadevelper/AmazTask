//
//  DetailsVC.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    
    
    //MARK:- IBOutlet :-
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var viewDetals: UIView!
    @IBOutlet weak var birthDateLB: UILabel!
    @IBOutlet weak var departmetLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var homePageBtn: UIButton!
    @IBOutlet weak var nameLB: UILabel!
    
    //MARK:- Variable & Constants :-
    
    var id_popular = 0
    var url_page : String = ""
    var  isSearching : Bool = false

    var transition = PopAnimator()
    weak var delegate : SearchBarProtocol?
    var photoList = [DetailsCellViewModel]() {
        didSet {
            self.setupSlide()
            self.collectionView.reloadData()
        }
    }
    lazy var viewModel : DetailsViewModel = {
        return DetailsViewModel()
    }()
    var detailsViewModel : ActorDetailsViewModel? {
        didSet {
            birthDateLB.text = detailsViewModel?.birthDay
            departmetLB.text = detailsViewModel?.knownForDepartment
            typeLB.text = detailsViewModel?.gender == 1 ? "Female" : "Male"
            nameLB.text = detailsViewModel?.name
            homePageBtn.setTitle(detailsViewModel?.homepage, for: .normal)
            self.url_page = detailsViewModel?.homepage ?? "-"
        }
    }
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        setupViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if isSearching {
        delegate?.showSearchBar()
        }
    }
    
    func setupViewModel() {
        
        viewModel.popualr_id = self.id_popular
        viewModel.error = { [weak self] errorMessage in
            guard let self = self else {
                return }
            Notify.toast(text: errorMessage, for: self.view) }
        
        viewModel.loading = {  isLoading in
            DispatchQueue.main.async {
                guard isLoading else{
                    LoadingIndicator.shared.hide()
                    return
                }
                LoadingIndicator.shared.show()
            }
        }
        viewModel.imageList = { [weak self] list in
            guard let self = self else {
                return
            }
            self.photoList = list
        }
        viewModel.actorDetails = { [weak self] detail in
            guard let self = self else {
                return
            }
            self.detailsViewModel = detail
        }
        
        viewModel.loadImage()
        viewModel.loadDetails()
    }
    
    //MARK:- To Load Page URL
    @IBAction func UrlAction(_ sender: Any) {
        
        if let url = URL(string: self.url_page) {
            UIApplication.shared.open(url) }
    }
}

//MARK:- Collection View Delegate & DataSource

extension DetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionCell", for: indexPath) as! DetailsCollectionCell
        cell.photoListCellViewModel = photoList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
    func setupSlide(){
        pageControll.currentPage = 0
        pageControll.numberOfPages = photoList.count
        pageControll.isHidden = pageControll.numberOfPages > 1 ? false : true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / (collectionView.frame.size.width )
        pageControll.currentPage = Int(pageNumber)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImageTableVC") as! ImageTableVC
        vc.image = URLs.base_url + photoList[indexPath.row].imageUrl
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)        
    }
    
}


// MARK: - UIViewControllerTransitioningDelegate

extension DetailsVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell =  collectionView.cellForItem(at: selectedIndexPathCell)  as? DetailsCollectionCell ,
            let selectedCellSuperview = selectedCell.superview
            else {
                return nil
        }
        transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transition.originFrame = CGRect(
            x: transition.originFrame.origin.x ,
            y: transition.originFrame.origin.y ,
            width: transition.originFrame.size.width ,
            height: transition.originFrame.size.height
        )
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
