//
//  ListCollectionViewCell.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var actionButton : (() -> Void)?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
