//
//  ImagesViewController.swift
//  CollectionViewDragAndDropSwift4
//
//  Created by SriAdat on 6/21/17.
//  Copyright © 2017 Sris. All rights reserved.
//

import UIKit
import Foundation

class ImagesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var imageNames = ["spa-alien-2", "spa-alien-abduction", "spa-capsule-entry",
                      "spa-dalek", "spa-saturn", "spa-shuttle", "spa-ufo"]
    var images = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = [UIImage(named: "spa-alien-2"), UIImage(named: "spa-alien-abduction"), UIImage(named: "spa-capsule-entry"), UIImage(named: "spa-dalek"), UIImage(named: "spa-saturn"), UIImage(named: "spa-shuttle"), UIImage(named: "spa-ufo")]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ImagesCollectionViewCell{
            cell.configureCell(image: images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ImagesViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //  get the UIImage that needs to be dragged from the indexPath
        let image = images[indexPath.row]
        // provide the image object to the  NSItemProvider
        let itemProvider = NSItemProvider(object: image!)
        // create and return the instance of UIDragItem
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator){
        /*
         coordinator.destinationIndexPath provides the destination IndexPath where content is being dropped. If it returns nil,then default behavior is to add the image in the new cell at the last of the collectionView.
         */
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let itemCount = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: itemCount, section: section)
        }
        /*
         coordinator.session loads the object of type UIImage from the NSItemProviderReadingItems.
         Read the first item in the array of nsItemProviderReadingItems - this is the new image that is being dropped.
         Here is the place to update the datasource, We are adding the new image to the images dataSource array at the identified destinationIndexPath
         Finally, we ask collectionView to insert new item at destinationIndexPath.
         */
        coordinator.session.loadObjects(ofClass: UIImage.self) { (nsItemProviderReadingItems) in
            if let imagesDropped = nsItemProviderReadingItems as? [UIImage] {
                if imagesDropped.count > 0 {
                    let newImage = imagesDropped[0]
                    self.images.insert(newImage, at: destinationIndexPath.row)
                    collectionView.insertItems(at: [destinationIndexPath])
                }
            }
        }
    }
}

