//
//  TaskListCell.swift
//  FM
//
//  Created by Łukasz Łuczak on 31/08/2021.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet var modificationDateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    private let imageManager: ImageManagerProtocol = ImageManager(networkManager: NetworkManager())
    
    func configure(orderId: Int, title: String, description: String, imageUrl: String, modificationDate: String) {
        configureAccessibilityIdentifiers(orderId: orderId)
        
        modificationDateLabel.text = modificationDate
        titleLabel.text = title
        descriptionLabel.text = description
        
        loadImage(imageUrl: imageUrl)
    }
    
    private func loadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        imageManager.getImage(url: url) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.photoView.image = image
            }
        }
    }
}

extension ListCell {
    func configureAccessibilityIdentifiers(orderId: Int) {
        accessibilityIdentifier = "\(orderId)"
        modificationDateLabel.accessibilityIdentifier = "\(orderId)-ModificationDatelabel"
        titleLabel.accessibilityIdentifier = "\(orderId)-TitleLabel"
        descriptionLabel.accessibilityIdentifier = "\(orderId)-DescriptionLabel"
        photoView.accessibilityIdentifier = "\(orderId)-PhotoImageView"
    }
}
