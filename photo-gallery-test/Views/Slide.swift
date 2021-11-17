import UIKit

class Slide: UIView {
    var photoLink: String = ""
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UITextView!
    @IBOutlet weak var labelDesc: UITextView!
    
    func downloadImage() {
        if(imageView.tag == 111){
            imageView.tag = 0
            imageView.downloaded(from: photoLink)
        }
        
    }
}

