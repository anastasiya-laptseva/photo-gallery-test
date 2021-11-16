//
//  PhotoViewController.swift
//  photo-gallery-test
//
//  Created by Anastasiya Laptseva on 16.11.21.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Image
    private let photoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subView: [UIView] = [self.photoImage, self.nameLabel]
    
    // MARK: - Init
    init(photoWith: PhotoHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.purple
        edgesForExtendedLayout = []
        
        photoImage.image = photoWith.image
        nameLabel.text = photoWith.name
        
        for view in subView {
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: photoImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: photoImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: photoImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: photoImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: photoImage, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
