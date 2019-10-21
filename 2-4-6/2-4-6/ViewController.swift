//
//  ViewController.swift
//  2-4-6
//
//  Created by 入江真礼 on 2019/10/20.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit
import FBSDKShareKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        let urlImage = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/0/0e/THSR_700T_Modern_High_Speed_Train.jpg")
//
//        let imageView = UIImageView()
//        imageView.center = CGPoint(x: view.center.x, y: 200)
//        imageView.image = UIImage(data: NSData(contentsOf: urlImage! as URL)! as Data)
//        imageView.contentMode = UIView.ContentMode.scaleAspectFit
//        view.addSubview(imageView)
//
//        let content = ShareLinkContent()
//        content.contentURL = urlImage! as URL
        
        let image = UIImage(named: "photosample")
        let photo = SharePhoto()
        let content = SharePhotoContent()
        photo.image = image
        content.photos = [photo]
        
        let shareButton = FBShareButton()
        shareButton.center = CGPoint(x: view.center.x, y: 500)
        shareButton.shareContent = content
        view.addSubview(shareButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
