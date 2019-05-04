//
//  dogAPI.swift
//  rendom
//
//  Created by Ghada Al on 14/05/1440 AH.
//  Copyright © 1440 ghadaalone. All rights reserved.
//

import Foundation
import UIKit
class dogAPI {
    enum Endpoint{
        
    case randomImageFromAllDogsCollection
    case randomImageForBreed(String)
        case listAllBreeds
        var url: URL {
            
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case.randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case.randomImageForBreed(let breed):
                return "https://dog.ceo/api/breeds/\(breed)/images/random"
            case.listAllBreeds:
                return "https://dog.ceo/api/breed/hound/list/all"

            }
            
        }
        
    }
    
    class func requestListBreeds(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, respose, error)
            in
            guard let data  = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
       task.resume()
        
    }
    
    
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (dogImage?, Error?) -> Void) {
        let randomImageEndpoint =
            dogAPI.Endpoint.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(dogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, error)
    }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downLoadImage = UIImage(data: data)
            completionHandler(downLoadImage, nil)
        })
        task.resume()
    }
}

