////
////  HomViewModel.swift
////  AmazTask
////
////  Created by Mostafa  on 8/19/20.
////  Copyright © 2020 Mostafa . All rights reserved.
////
//
import UIKit
import Foundation

class HomeViewModel {
    
    private var movies : [Results] = [Results]()
    private var cellViewModels: [HomeCellViewModel] = [HomeCellViewModel]()
    var loading :((Bool) ->())!
    var error : ((String)-> ())!
    var moviesList :(([HomeCellViewModel])->())!
    var selectedResult: Results?
    var total_page : Int = 1
    var page : Int = 1
    var isSearching = false
    var searchTerm = ""
    
}

extension HomeViewModel {
    
    func resetValues() {
        page = 1
        movies = []
        total_page = 1
        searchTerm = ""
    }
    
    //MARK:- To load data From API
    func fetchData() {
        
        guard self.page <= self.total_page else { return }

        
        var paramter : [String : Any] = [:]
        var url = ""
        if isSearching {
            paramter = [ "api_key" : URLs.api_key , "query" : self.searchTerm ,"page" : page ]
            url = URLs.search_name
        }else {
            paramter  = [ "api_key" : URLs.api_key ,"page" : page ]
            url = URLs.popular_peaple
        }
                
        self.loading(true)
        APIs.instance.getData(parameter: paramter , url: url) {[weak self] (movies : PopularPeaple?, error) in
            
            guard let self = self else { return }
            self.loading(false)
            guard error == nil else {
                self.error("Something wrong happened \(error?.localizedDescription ?? "")")
                return
            }
            
            self.total_page = movies?.total_pages ?? 0
            self.page += 1
            self.processFetchedResult(result: movies?.results ?? [])
        }
    }

    
    func getCellViewModel( at indexPath: IndexPath ) -> HomeCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(at result : Results) -> HomeCellViewModel {
        
        HomeCellViewModel(name: result.name ?? "" , imageUrl: result.profile_path ?? "" , gender: result.gender  ?? 1 )
    }
    
    private func processFetchedResult(result : [Results]) {
        
        if self.movies.count == 0 {
            self.movies = result
        }else{
            self.movies.append(contentsOf: result)
        }
        self.movies = self.movies.unique
        
        var list = [HomeCellViewModel]()
        for movie in movies {
            list.append(createCellViewModel(at: movie))
        }
        self.cellViewModels = list
        
        self.moviesList(self.cellViewModels)
    }
    
    func didSelect( at indexPath: IndexPath ){
        let movie = self.movies[indexPath.row]
        self.selectedResult = movie
    }
}


