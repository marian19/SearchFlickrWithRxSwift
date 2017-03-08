//
//  Photos.swift
//  SearchFlickrWithRxSwift
//
//  Created by Marian on 3/8/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import Mapper

struct Photos: Mappable {
    
    let photos: [Photo]?
    
    
    init(map: Mapper) throws {
        try photos = map.from("photo")
            }
    
    
}
