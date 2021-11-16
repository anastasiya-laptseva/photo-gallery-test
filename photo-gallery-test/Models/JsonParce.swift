//
//  JsonParce.swift
//  photo-gallery-test
//
//  Created by Anastasiya Laptseva on 15.11.21.
//

import UIKit

public class JsonParce {
    
    func parceJson(complection:@escaping ([Photo])->Void){
        var photos: [Photo] = []
        
        let urlString = "http://dev.bgsoft.biz/task/credits.json"
        
        guard let url = URL(string: urlString) else {
            complection(photos)
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data {
                do {
                    if let dictionary =
                      try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        for key in dictionary.keys {
                            let value = dictionary[key]
                            let data = try JSONSerialization.data (withJSONObject: value ?? "", options: [])
                            let decodedResult = try JSONDecoder().decode(Photo.self, from: data)
                            photos.append(decodedResult)
                        }
                    }
                
                    complection(photos)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    complection(photos)
                }
            }
            else{
                complection(photos)
            }
        }.resume()
    }
}
    
    

//do {
//    if let dictionary =
//      try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//        for key in dictionary.keys {
//            let value = dictionary[key]
//            let data = try JSONSerialization.data (withJSONObject: value ?? "", options: [])
//            let decodedResult = try JSONDecoder().decode(Photo.self, from: data)
//            photos.append(decodedResult)
//        }
//    }
//
//    completionHandler(photos)
//} catch let error as NSError {
//    print("Failed to load: \(error.localizedDescription)")
//    completionHandler(photos)
//}
//completionHandler(photos)
    
    

