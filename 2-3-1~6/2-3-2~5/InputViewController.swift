//
//  AddViewController.swift
//  2-3-2~5
//
//  Created by 入江真礼 on 2019/10/11.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit
import RealmSwift

class InputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.frame.size.height = 30
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addButtonTapped(_ sender: Any) {

        let newTodo = trTodo()
    
        // textFieldに入力したデータをnewTodoのtitleに代入
        newTodo.todoTitle = titleTextField.text!
        newTodo.todoContents = contentsTextField.text!
        
        //dateFormaterを作成
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd"
        
        //登録日にはボタンタップ時点での日付時刻
        let date = dateFormater.string(from: Date())
        //期限日はボタンタップ時点から２４時間後の時刻
        let tomorrow = dateFormater.string(from: Date(timeIntervalSinceNow: 60*60*24))
        
        newTodo.created = date
        newTodo.modified = date
        newTodo.limitDate = tomorrow
        
        
        // 上記で代入したテキストデータを永続化
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newTodo)
                print("ToDo Saved")
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            })
        }catch{
            print("Save is Faild")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

