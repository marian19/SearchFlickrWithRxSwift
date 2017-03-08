//
//  FlickrEndPoints.swift
//  SearchFlickrWithRxSwift
//
//  Created by Marian on 3/8/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum Flickr {
    case searchPhotosByKeyword(keyword: String)
    
}

extension Flickr: TargetType {
    /// Provides stub data for use in testing.
  

    var baseURL: URL { return URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=44761f64191a244f94126acb50e1c22d&text=sky&format=json&nojsoncallback=1")! }
   
//    var baseURL: URL { return URL(string: "https://api.flickr.com/services/rest/?")! }
    var path: String {
        switch self {
        case .searchPhotosByKeyword(_):
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .searchPhotosByKeyword(_):
            return .get
        }
    }
    var parameters: [String: Any]? {
//        switch self {
//        case .searchPhotosByKeyword(let keyword):
//            return [
//                "method": "flickr.photos.search",
//                "api_key": "44761f64191a244f94126acb50e1c22d",
//                "text"  :keyword,
//                "per_page" : 20,
//                "page" : 1,
//                "format" : "json" ,
//                "nojsoncallback" : 1]
//            
//        }
        return nil
    }
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    var task: Task {
        return .request
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
