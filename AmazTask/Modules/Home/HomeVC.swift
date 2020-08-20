//
//  ViewController.swift
//  AmazTask
//
//  Created by Mostafa  on 8/17/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import UIKit

class HomeVC: UIViewController{
    
    //MARK:- <======== IbOutlet ========>
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoSearchLB: UILabel!
    
    //MARK:- Variable & Constants :-
    private var searchController : UISearchController!
    
    var moviesList = [HomeCellViewModel](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    lazy var viewModel : HomeViewModel  = {
        return HomeViewModel()
    }()
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(cell: HomeTableCell.self)
    }
    
    func setupViewModel() {
        
        viewModel.error = { [weak self] errorMessage in
            guard let self = self else {
                return
            }
            Notify.toast(text: errorMessage, for: self.view)
        }
        
        viewModel.loading = {  isLoading in
            DispatchQueue.main.async {
                guard isLoading else{
                    LoadingIndicator.shared.hide()
                    return
                }
                LoadingIndicator.shared.show()
            }
        }
        
        viewModel.moviesList = { [weak self] list in
            guard let self = self else {
                return
            }
            self.moviesList = list
        }
        
        viewModel.fetchData()
    }
    
    
    
    @IBAction func serachAction(_ sender: Any) {
        presentSearchBar()
    }
    
    
}


//MARK:- HomeVC Extension
extension HomeVC {
    
    func presentSearchBar() {
        // Create the search controller and specify that it should present its results in this same view
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.setup(placeHolder:"Search")
        searchController.hidesNavigationBarDuringPresentation = false
        self.moviesList.removeAll()
        viewModel.isSearching = true
        searchController.dimsBackgroundDuringPresentation = false
        UIApplication.shared.statusBarUIView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.present(searchController, animated: true, completion: nil)
    }
    
    
}




//MARK:- Table View data Source

extension HomeVC :  UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as HomeTableCell
        cell.listCellViewModel = moviesList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.size.height / 9
    }
    
}


//MARK:- table View Delegate Action

extension HomeVC : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.didSelect(at: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        
        vc.isSearching = viewModel.isSearching ? true : false
                vc.delegate = self

        if let id  = self.viewModel.selectedResult?.id {
            vc.id_popular = id
        }
        show(vc, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = moviesList.count
        if count == indexPath.row + 1 { viewModel.fetchData() }
    }

}

//MARK: - Conform Search Delegates
extension HomeVC : UISearchControllerDelegate,UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard  let text = searchBar.text else {return}
        DispatchQueue.main.async(execute: {
            self.viewModel.resetValues()
            self.viewModel.searchTerm = text
            self.tableView.reloadData()
            self.viewModel.fetchData()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        DispatchQueue.main.async(execute: {
            self.viewModel.searchTerm = ""
            self.viewModel.isSearching = false
            self.viewModel.resetValues()
            self.viewModel.fetchData()
        })
    }
    
}


extension HomeVC : SearchBarProtocol {
    
    func showSearchBar() {
        self.presentSearchBar()
    }
}
