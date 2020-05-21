//
//  SearchImageCollectionViewCell.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.image = UIImage(named: "placeHolderImage")
    }
    
    override func prepareForReuse() {
        itemImageView.image = UIImage(named: "placeHolderImage")
    }

}
