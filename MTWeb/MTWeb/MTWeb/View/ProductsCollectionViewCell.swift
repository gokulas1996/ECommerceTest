//
//  ProductsCollectionViewCell.swift
//  MTWeb
//
//  Created by Gokul A S on 04/06/23.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deliveryImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.borderWidth = 1.0
    }
}
