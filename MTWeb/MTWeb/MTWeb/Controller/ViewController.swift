//
//  ViewController.swift
//  MTWeb
//
//  Created by Gokul A S on 02/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var bannerCollectionView: UICollectionView!
    
    private var viewModel = ViewControlViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFetchedData()
    }
    
    func setFetchedData() {
        let collectionViews = [self.categoryCollectionView, self.productsCollectionView, self.bannerCollectionView]
        self.viewModel.fetchDataFromService(completion: { order in
            for cv in collectionViews {
                cv?.reloadData()
            }
            
            for viewOrder in order {
                if let categoryOrder = viewOrder[Sections.category.rawValue] {
                    self.mainStackView.insertArrangedSubview(self.categoryCollectionView, at: categoryOrder)
                }
                
                if let bannerOrder = viewOrder[Sections.banners.rawValue] {
                    self.mainStackView.insertArrangedSubview(self.bannerCollectionView, at: bannerOrder)
                }
                
                if let productOrder = viewOrder[Sections.products.rawValue] {
                    self.mainStackView.insertArrangedSubview(self.productsCollectionView, at: productOrder)
                }
            }
        })
        
        for cv in collectionViews {
            cv?.delegate = self
            cv?.dataSource = self
        }
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViews = [self.categoryCollectionView, self.productsCollectionView, self.bannerCollectionView]
        if collectionView == categoryCollectionView {
            return self.viewModel.category?.count ?? 1
        } else if collectionView == bannerCollectionView {
            return self.viewModel.banners?.count ?? 1
        } else {
            return self.viewModel.products?.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.categoryCell, for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryLabel.text = self.viewModel.category?[indexPath.row].name
            if let imageURLString = self.viewModel.category?[indexPath.row].image_url, let imageURL = URL(string: imageURLString) {
                categoryCell.categoryImageView.backgroundColor = Colors.bgColor[indexPath.row]
                categoryCell.categoryImageView.downloaded(from: imageURL)
            }
            return categoryCell
        } else if collectionView == self.bannerCollectionView {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.bannerCell, for: indexPath) as! BannerCollectionViewCell
            if let imageURLString = self.viewModel.banners?[indexPath.row].banner_url, let imageURL = URL(string: imageURLString) {
                bannerCell.bannerImageView.downloaded(from: imageURL)
            }
            return bannerCell
        } else {
            let productsCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.productsCell, for: indexPath) as! ProductsCollectionViewCell
            productsCell.productNameLabel.attributedText = NSAttributedString(string: "\(self.viewModel.products?[indexPath.row].name ?? "")", attributes: nil)
            if let imageURLString = self.viewModel.products?[indexPath.row].image, let imageURL = URL(string: imageURLString) {
                productsCell.productImageView.downloaded(from: imageURL)
            }
            productsCell.deliveryImageView.isHidden = self.viewModel.products?[indexPath.row].is_express == true ? false : true
            productsCell.discountLabel.isHidden = self.viewModel.products?[indexPath.row].offer ?? 0 > 0 ? false : true
            productsCell.discountLabel.attributedText = NSAttributedString(string: " \(self.viewModel.products?[indexPath.row].offer ?? 0) % OFF ")
            if self.viewModel.products?[indexPath.row].offer_price == self.viewModel.products?[indexPath.row].actual_price {
                productsCell.offerPriceLabel.isHidden = true
            } else {
                let attributes: [NSAttributedString.Key : Any] = [
                    NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.strikethroughColor: Colors.offerPriceColor,
                ]
                productsCell.offerPriceLabel.attributedText = NSAttributedString(string: "\(self.viewModel.products?[indexPath.row].offer_price ?? "0")", attributes: attributes)
            }
            productsCell.actualPriceLabel.attributedText = NSAttributedString(string: "\(self.viewModel.products?[indexPath.row].actual_price ?? "0")")
            return productsCell
        }
    }
}


