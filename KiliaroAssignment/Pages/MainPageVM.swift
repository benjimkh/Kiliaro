//
//  mainPageVM.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/28/21.
//

import Foundation
import SDWebImage

class MainPageVM : NSObject {
    var imageData : [model._image]! {
        didSet {
            self.bindDatasourceViewModelToController()
        }
    }
    
    var bindDatasourceViewModelToController : (() -> ()) = {}

    override init() {
        super.init()
        callSharedAlbumImagesAPI()
    }
    func manageCache() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }

    func callSharedAlbumImagesAPI() {
        NetworkingLayer.request(router: .getSharedAlbum) { (result: Result<[model._image], Error>) in
            switch result {
            case Result.success(let response):
                print(response)
                self.imageData = response
            case Result.failure(let error):
                print(error)
            }
        }

    }
}
