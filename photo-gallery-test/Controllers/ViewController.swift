import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides:[Slide] = [];
    var lastPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastPageIndex = 0
        JsonParce().parceJson { users in
            DispatchQueue.main.async() {
                self.slides = self.createSlides(users: users)
                self.setupSlideScrollView(slides: self.slides)
                self.pageControl.numberOfPages = users.count
                self.pageControl.currentPage = 0
                self.view.bringSubviewToFront(self.pageControl)
                self.slides[0].downloadImage()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func createSlides(users: [User]) -> [Slide] {
        
        var array:[Slide] = []
        
        for user in users {
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.photoLink = "http://dev.bgsoft.biz/task/\(user.user_key).jpg"
            slide.labelTitle.text = user.photo.user_name
            
            let attributedString = NSMutableAttributedString(string: "User and Photo")
            let url1 = URL(string: user.photo.user_url)!
            let url2 = URL(string: user.photo.photo_url)!
            attributedString.addAttributes([.link: url1], range: NSMakeRange(0, 4))
            attributedString.addAttributes([.link: url2], range: NSMakeRange(9, 5))
            slide.labelDesc.attributedText = attributedString
            slide.labelDesc.isUserInteractionEnabled = true
            slide.labelDesc.isEditable = false
            slide.labelDesc.linkTextAttributes = [
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            slide.labelDesc.font = UIFont.systemFont(ofSize: 20.0)
            slide.labelDesc.textAlignment = .center
            
            array.append(slide)
        }
        
        return array
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        let index = Int(pageIndex)
        pageControl.currentPage = index
        let slide = slides[index]
        if(lastPageIndex != index) {
            lastPageIndex = index
            slide.downloadImage()
        }
    }
}

