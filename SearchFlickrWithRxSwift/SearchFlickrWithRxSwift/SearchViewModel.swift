//
//  SearchViewModel.swift
//  SearchFlickrWithRxSwift
//
//  Created by Marian on 3/8/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

struct SearchViewModel {
    
    let keywordObservable: Observable<String>
    
    func searchPhotos() -> Observable<[Photo]> {
        return keywordObservable
            .observeOn(MainScheduler.instance)
            .flatMapLatest({ text -> Observable<[Photo]> in
                
                print("keyword is : \(text)")
                return Observable.create({ observer -> Disposable in
                    let postBody = [  "method": "flickr.photos.search",
                                      "api_key": "44761f64191a244f94126acb50e1c22d",
                                      "text"  :text,
                                      "per_page" : 20,
                                      "page" : 1,
                                      "format" : "json" ,
                                      "nojsoncallback" : 1] as [String : Any]
                    
                    let request = Alamofire.request( "https://api.flickr.com/services/rest/?", parameters: postBody)
                        .responseJSON(completionHandler: { (firedResponse) -> Void in
                            if let value = firedResponse.result.value {
                                
                                let json = JSON(value)
                                var photos:[Photo] = []
                                
                                for item in json["photos"]["photo"].arrayValue{
                                    let photo = Photo.init(jsonDictionary: item)
                                    photos.append(photo)
                                    
                                }
                                observer.onNext(photos)
                                observer.onCompleted()
                            } else if let error = firedResponse.result.error {
                                observer.onError(error)
                            }
                        })
                    return Disposables.create {
                        print("Disposed")
                        
                        request.cancel()
                    }
                })
            })
        

    }
    
}
