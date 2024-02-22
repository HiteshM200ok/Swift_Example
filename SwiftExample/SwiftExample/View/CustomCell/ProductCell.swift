//
//  ProductCell.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import UIKit

class ProductCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
    }
}
