//
//  ViewController.swift
//  photo-gallery-test
//
//  Created by Anastasiya Laptseva on 11.11.21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    //MARK: - Variable
    var photos = [PhotoHelper]()
    let first = UIImage(named: "first")
    let second = UIImage(named: "second")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photos"
        
        let firstPhoto = PhotoHelper(name: "Photo - first", image: first!)
        let secondPhoto = PhotoHelper(name: "Photo - second", image: second!)
        photos.append(firstPhoto)
        photos.append(secondPhoto)
    }
    
    //MARK: - Create VC
    lazy var arrayPhotoViewController: [PhotoViewController] = {
        var photoVC = [PhotoViewController]()
        for photo in photos {
            photoVC.append(PhotoViewController(photoWith: photo))
        }
        return photoVC
    }()
    
    //MARK: - init UIPageViewController
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.green
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayPhotoViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoViewController else { return nil }
        if let index = arrayPhotoViewController.index(of: viewController) {
            if index > 0 {
                return arrayPhotoViewController[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PhotoViewController else { return nil }
        if let index = arrayPhotoViewController.index(of: viewController) {
            if index < photos.count - 1 {
                return arrayPhotoViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
