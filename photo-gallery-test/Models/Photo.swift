//
//  Photo.swift
//  photo-gallery-test
//
//  Created by Anastasiya Laptseva on 15.11.21.
//

struct User{
    var user_key: String
    var photo: Photo
}

struct Photo: Codable {
    var user_name: String
    var user_url: String
    var photo_url: String
    var colors: [String]
}

