//
//  ViewController.swift
//  2-1-6
//
//  Created by 入江真礼 on 2019/10/03.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    func testloadView() {
        
        // 2 WKWebViewConfiguration の生成
        let webConfiguration = WKWebViewConfiguration()
        
        let screenSize = UIScreen.main.bounds
        let width = screenSize.width
        let hegiht = screenSize.height
        // 3 WKWebView に Configuration を引き渡し initialize
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: width, height: hegiht - 44 - 44), configuration: webConfiguration)
        
        webView.backgroundColor = .red
        // 4 WKUIDelegate の移譲先として self を登録
        webView.uiDelegate = self
        // 5 WKNavigationDelegate の移譲先として self を登録
        webView.navigationDelegate = self
        // 6 view に webView を割り当て
//        view = webView
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testloadView()
        
        // 7 URLオブジェクトを生成
        let myURL = URL(string:"https://www.apple.com")
        // 8 URLRequestオブジェクトを生成
        let myRequest = URLRequest(url: myURL!)
        
        // 9 URLを WebView にロード
        webView.load(myRequest)
    }
    

    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBAction func backPage(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    //cangoback
    
    @IBAction func nextPage(sender: UIBarButtonItem) {
        self.webView.goForward()
    }
//cangoforward
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let error = error as NSError
        
        if error.code == -1009 {
            print("offline")
            //オフライン時の処理
        }
    }
}




// MARK: - 10 WKWebView ui delegate
extension ViewController: WKUIDelegate {
    // delegate
}

// MARK: - 11 WKWebView WKNavigation delegate
extension ViewController: WKNavigationDelegate {
    // delegate
}

