//
//  ViewController.swift
//  2-5-4
//
//  Created by 入江真礼 on 2019/10/21.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "アラジン")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var imgView2: UIImageView!
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
        let image = info[.originalImage] as! UIImage
        
        imgView.image = image
        
        let ciImage:CIImage = CIImage(image:image)!;
        let ciFilter:CIFilter = CIFilter(name: "CIHueAdjust" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(3.14, forKey: "inputAngle")
        let ciContext:CIContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        
        //image2に加工後のUIImage
        let image2:UIImage? = UIImage(cgImage: cgimg, scale: 0, orientation:image.imageOrientation)

        imgView2.image = image2
        
        self.dismiss(animated: false)
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
