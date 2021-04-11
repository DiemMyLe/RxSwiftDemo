//
//  CollectionViewCell.swift
//  DemoCleanProductList
//
//  Created by DiemMy Le on 4/7/21.
//  Copyright © 2021 DiemMy Le. All rights reserved.
//

import UIKit
import Reusable

class CollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var lbCollectionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
