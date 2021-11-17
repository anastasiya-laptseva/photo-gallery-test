import UIKit

class Slide: UIView {
    var photoLink: String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UITextView!
    @IBOutlet weak var labelDesc: UITextView!
    
    func downloadImage() {
        imageView.downloaded(from: photoLink)
    }
}

