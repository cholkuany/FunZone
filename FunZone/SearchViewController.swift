//
//  SearchViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webKitView = WKWebView()
        let newUrl = URL(string: "https://www.google.com/?client=safari")!
        webKitView.load(URLRequest(url: newUrl))
        view = webKitView

    }
    

}
