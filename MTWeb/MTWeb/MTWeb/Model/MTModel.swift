//
//  MTModel.swift
//  MTWeb
//
//  Created by Gokul A S on 02/06/23.
//

import Foundation

enum Sections: String {
    case category
    case banners
    case products
}

struct WebData: Codable {
    var status: Bool
    var homeData: [HomeData]?
}

struct HomeData: Codable {
    var type: String
    var values: [Value]
}

struct Value: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var actual_price: String?
    var offer_price:String?
    var offer: Int?
    var is_express: Bool?
    var image_url: String?
    var banner_url: String?
}

