//
//  ViewController.swift
//  2-4-8
//
//  Created by 入江真礼 on 2019/10/21.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker: UIImagePickerController!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true // Whether to make it possible to edit the size etc after selecting the image
        // set picker's navigationBar appearance
        picker.view.backgroundColor = .white
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.barTintColor = .blue
        picker.navigationBar.tintColor = .white
        picker.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ] // Title color
        button = UIButton()
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: UIControl.Event.touchUpInside)
        let size = view.frame.width * 0.8
        button.setTitle("Push Me", for: UIControl.State.normal)
        button.frame.size = CGSize(width: size, height: size)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.center = view.center
        button.backgroundColor = .orange
        view.addSubview(button)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        // show picker modal
        present(picker, animated: true, completion: nil)
}
    // MARK: ImageVicker Delegate Methods
    // called when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let linkURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL else { return }
        
        guard let openURL = URL(string: "instagram://library?LocalIdentifier=\(linkURL.absoluteString)") else { return }
        
        picker.dismiss(animated: true, completion: {
            
            if UIApplication.shared.canOpenURL(openURL) {
                
                UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
                
            } else {
                
                print("error")
                
            }
            
        })
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            button.setBackgroundImage(editedImage, for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            button.setBackgroundImage(originalImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // called when cancel select image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // close picker modal
        dismiss(animated: true, completion: nil)
    }
}
