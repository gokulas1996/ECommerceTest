//
//  ViewControlViewModel.swift
//  MTWeb
//
//  Created by Gokul A S on 06/06/23.
//

import Foundation

class ViewControlViewModel {
    
    var webData: WebData?
    var networkManager = NetworkManager.self
    var category: [Value]?
    var banners: [Value]?
    var products: [Value]?
    var index: Int = -1
    var viewOrder: [[String: Int]] = [[:]]
    
    func fetchDataFromService(completion: @escaping (_ order: [[String: Int]])  -> ()) {
        self.networkManager.shared.fetchData { web, err in
            if let err = err {
                print(Strings.error, err)
                return
            }
            if let web {
                self.webData = web
                if let values = self.webData?.homeData {
                    for value in values {
                        switch value.type {
                        case Sections.category.rawValue:
                            self.category = value.values
                            self.index = self.index + 1
                            self.viewOrder.append([Sections.category.rawValue: self.index])
                            break
                        case Sections.banners.rawValue:
                            self.banners = value.values
                            self.index = self.index + 1
                            self.viewOrder.append([Sections.banners.rawValue: self.index])
                            break
                        case Sections.products.rawValue:
                            self.products = value.values
                            self.index = self.index + 1
                            self.viewOrder.append([Sections.products.rawValue: self.index])
                            break
                        default: break
                        }
                    }
                    completion(self.viewOrder)
                }
            }
        }
    }
}
