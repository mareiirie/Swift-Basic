//
//  ViewController.swift
//  2-1-7
//
//  Created by 入江真礼 on 2019/10/07.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var maxLengths = [UITextField: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view.
    }

//entEditingをtouchesBegan機能として実装
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 入力を反映させたテキストを取得する
        let resultText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if resultText.count <= 30 {
            return true
        }
        return false
    }

}

////////maxlength設定機能を拡張したけれど、入力までは制限されていない・・・？
//extension UITextField {
//    @IBInspectable var maxLength: Int {
//        get {
//            guard let length = maxLengths[self] else {
//                return Int.max
//            }
//
//            return length
//        }
//        set {
//            maxLengths[self] = newValue
//            addTarget(self, action: #selector(limitLength), for: .editingChanged)
//        }
//    }
//
//    @objc func limitLength(textField: UITextField) {
//        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
//            return
//        }
//
//        let selection = selectedTextRange
//        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//
//        #if swift(>=4.0)
//        text = String(prospectiveText[..<maxCharIndex])
//        #else
//        text = prospectiveText.substring(to: maxCharIndex)
//        #endif
//
//        selectedTextRange = selection
//    }
//
//}
