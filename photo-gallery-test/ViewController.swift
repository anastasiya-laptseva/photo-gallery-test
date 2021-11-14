//
//  ViewController.swift
//  photo-gallery-test
//
//  Created by Anastasiya Laptseva on 11.11.21.
//

import UIKit

struct Photo: Codable {
    var user_name: String
    var user_url: String
    var photo_url: String
    var colors: [String]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://dev.bgsoft.biz/task/credits.json"
        if let url = URL(string: urlString) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                      if let dictionary =
                        try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                          for key in dictionary.keys {
                              let value = dictionary[key]
                              let data = try JSONSerialization.data (withJSONObject: value ?? "", options: [])
                              let decodedResult = try JSONDecoder().decode(Photo.self, from: data)
                              self.photos.append(decodedResult)
                          }
                          self.endLoadPhoto()
                      }
                  } catch let error as NSError {
                      print("Failed to load: \(error.localizedDescription)")
                  }
              }
           }.resume()
        }
        
        print("EndViewDidLoad")
        
    }
    
    func endLoadPhoto() {
        print("EndParcing")
        for photo in photos {
            print("photourl: \(photo.photo_url)")
        }
    }


}

