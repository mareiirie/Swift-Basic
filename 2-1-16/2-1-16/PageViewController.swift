//
//  ViewController.swift
//  2-1-16
//
//  Created by 入江真礼 on 2019/10/09.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self as UIPageViewControllerDataSource
    }
    
    
    //instantiateViewControllerはstoryboardで定義したidentifierでviewcontrollerを呼ぶメソッド。
    //get firstは、storyboardのidentifierに紐づくviewcontrollerを、FirstViewControllerに呼んでいる。
    func getFirst() -> FirstViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }
    
    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //ThirdViewControllerクラスなら、get Secondメソッドを呼ぶ。Secondクラスなら、Firstメソッドを呼ぶ。pageviewController機能としてBefore「前ページ」となるモーションを期待されているので、returnするクラスは前に置きたいclass
        
        if viewController.isKind(of: ThirdViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return getFirst()
        } else {
            return nil
        }
    }
    
    //上記の逆バージョン。Afterなので、returnするクラスは次に置きたいクラス。
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: FirstViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return getThird()
        } else {
            return nil
        }
    }
}

