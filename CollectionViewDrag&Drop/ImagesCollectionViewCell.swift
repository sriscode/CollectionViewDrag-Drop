//
//  ImagesCollectionViewCell.swift
//  CollectionViewDragAndDropSwift4
//
//  Created by SriAdat on 6/21/17.
//  Copyright © 2017 Sris. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: UIImage?) {
        if let image = image {
            imageView.image = image
        }
    }
}

