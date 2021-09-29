//
//  Router.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/28/21.
//

import Foundation

enum Router {
    case getSharedAlbum
    // we will devide each route in 4 diff parts
    ///-method ( get - post - ... )
    ///-scheme ( http or https)
    ///-mainUrl
    ///-path
    var method: String {
      switch self {
        case .getSharedAlbum :
          return "GET"
      }
    }

    var scheme: String {
        switch self {
        case .getSharedAlbum :
            return "https"
        }
    }
    var mainUrl: String {
        switch self {
        case .getSharedAlbum :
            return "api1.kiliaro.com"
        }
    }
    var path: String {
        let sharedID = "djlCbGusTJamg_ca4axEVw"
        switch self {
        case .getSharedAlbum:
            return "/shared/\(sharedID)/media"
        }
    }
    
    
}
    

