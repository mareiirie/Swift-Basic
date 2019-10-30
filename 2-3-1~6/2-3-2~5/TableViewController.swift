//
//  ViewController.swift
//  2-3-2~5
//
//  Created by 入江真礼 on 2019/10/10.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    var todoItem: Results<ListTodo>!
//    lazy var items = Array(todoItem)

    override func viewDidLoad() {
        super.viewDidLoad()
         //永続化されているデータをフィルターかけて取りだし、todoItemに代入。todoItemはresult型になっている。
        do{
            let realm = try Realm()
            todoItem = realm.objects(ListTodo.self)
            todoItem = todoItem.filter("deleteFlg = false")
            todoItem = todoItem.sorted(byKeyPath: "limitDate", ascending: false)
            tableView.reloadData()
            print("①−２オブジェクトtodoItemを代入:todoItem数\(todoItem.count)")
        }catch{

        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? TodoCell {
 
            print("②−１カスタムセルを呼び出し:todoItem数\(todoItem.count)")
            let object = todoItem[indexPath.row]

                cell.titleLabel.text = object.todoTitle
                cell.limitLabel.text = object.limitDate
            print("②−２カスタムセルを呼び出し、todoItemのテキストを代入:todoItem数\(todoItem.count)")

        return cell
    }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        print("③カスタムセルの編集許可:todoItem数\(todoItem.count)")
        return true
    }
//    // TableViewのCellの削除を行った際に、Realmに保存したデータも削除する場合
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if(editingStyle == UITableViewCell.EditingStyle.delete) {
//            do{
//                let realm = try Realm()
//                try realm.write {
//                    realm.delete(self.todoItem[indexPath.row])
//                }
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }catch{
//            }
//            tableView.reloadData()
//        }
//    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
print("④−１削除実行:todoItem数\(todoItem.count)")
        let removeitm = todoItem[indexPath.row]
//        var todoitems = Array(todoItem)
        let id = removeitm.todoID
//        let removeitem = todoItem[indexPath.row]
        var items = Array(todoItem)
print("④−２削除実行しindexPathの該当IDを代入:todoItem数\(todoItem.count)items数\(items.count)")
                if(editingStyle == UITableViewCell.EditingStyle.delete) {
                    do{
                        let realm = try Realm()
                            try realm.write {
                            let value: [String: Any] = ["todoID": id, "deleteFlg": true]
                                realm.create(ListTodo.self, value: value, update: true)
                        }
print("ToDo Saved")
print("④−３RealmにtodoItemの削除フラグ上書き:todoItem数\(todoItem.count)items数\(items.count)")
                            print(Realm.Configuration.defaultConfiguration.fileURL!)
                        
                        items.remove(at: indexPath.row)
print("④−４items.remove:todoItem数\(todoItem.count)items数\(items.count)")
                        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
print("④−５deleteRows:todoItem数\(todoItem.count)items数\(items.count)")
                    }catch{
                    }
                    tableView.reloadData()
print("④−６削除後リロード:todoItem数\(todoItem.count)items数\(items.count)")
                }

}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
print("⑤セルの数指定:todoItem数\(todoItem.count)")
        return todoItem.count //realmにフィルターをかけてtablecellの数を定めているので、これは動かせない
    }


}
