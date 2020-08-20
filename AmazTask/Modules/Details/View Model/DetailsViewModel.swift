//
//  DetailsViewModel.swift
//  AmazTask
//
//  Created by Mostafa  on 8/19/20.
//  Copyright © 2020 Mostafa . All rights reserved.
//

import Foundation
import UIKit

class DetailsViewModel {
    
    private var photos: [Profile] = [Profile]()
    private var details : PopularDetails = PopularDetails()
    private var cellViewModel : [DetailsCellViewModel] = [DetailsCellViewModel]()
    private var actorViewModel : ActorDetailsViewModel = ActorDetailsViewModel()
    var loading :((Bool) ->())!
    var error : ((String)-> ())!
    var imageList :(([DetailsCellViewModel])->())!
    var actorDetails : ((ActorDetailsViewModel)->())!
    var selectedPhoto : Profile?
    var popualr_id = 0
    
}

extension DetailsViewModel {
    
    //MARK:- To Load data From API
    func loadImage(){
        
        self.loading(true)
        
        APIs.instance.getData(parameter: ["api_key":URLs.api_key],
                              url: URLs.get_popular_image+"\(self.popualr_id)/images") {[weak self] (photos : Profile_Image?, error) in
                                guard let self = self else { return }
                                self.loading(false)
                                guard error == nil else {
                                    self.error("\(Messages.erorr)\(error?.localizedDescription ?? "")")
                                    return
                                }
                                self.processFetchedPhotos(photos: photos?.profiles ?? [])
        }
        
    }
    
    private func processFetchedPhotos(photos : [Profile]) {
        self.photos = photos // Cache
        
        var listPhoto = [DetailsCellViewModel]()
        for photo in photos {
            listPhoto.append(createCellViewModel(at: photo))
        }
        self.cellViewModel = listPhoto
        self.imageList(self.cellViewModel)
    }
    
    
    private func processFetchDetails(details : PopularDetails ) {
        
        self.details = details
        let details = ActorDetailsViewModel(name: details.name ?? "", gender: details.gender ?? 0, birthDay: details.birthday ?? "", homepage: details.homepage ?? "", knownForDepartment: details.known_for_department ?? "")
        self.actorViewModel = details
        actorDetails(details)
    }
    
    func loadDetails(){
        
        self.loading(true)
        
        APIs.instance.getData(parameter: ["api_key":URLs.api_key], url: URLs.details_peaple+"\(self.popualr_id)") {[weak self] (popualr : PopularDetails?, error) in
            
            
            guard let self = self else { return }
            self.loading(false)
            
            guard error == nil else {
                self.error("\(Messages.erorr)\(error?.localizedDescription ?? "")")
                return
            }
            self.processFetchDetails(details : popualr!)
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> DetailsCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    
    func getDetailsViewModel() -> ActorDetailsViewModel {
        return actorViewModel
    }
    
    func createCellViewModel(at photo : Profile) -> DetailsCellViewModel {
        
        return DetailsCellViewModel(imageUrl: photo.file_path!)
    }
    
    func CreateDetailsViewModel(at details : PopularDetails) -> ActorDetailsViewModel {
        
        ActorDetailsViewModel(name: details.name ?? "-", gender: details.gender ?? 1 , birthDay: details.birthday ?? "-", homepage: details.homepage ?? "-", knownForDepartment: details.known_for_department ?? "-")
    }
    
    func didSelect( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
        self.selectedPhoto = photo
    }
    
}









