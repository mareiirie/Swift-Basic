//
//  ViewController.swift
//  2-5-4
//
//  Created by 入江真礼 on 2019/10/21.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBAction func toAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        imgView.image = image
        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextView = storyboard.instantiateViewController(withIdentifier: "Photo") as! PhotoViewController
//        nextView.image = image
        
        self.dismiss(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
