//
//  DetailedViewController.swift
//  Project 7: Whitehouse Petitions(JSON)
//
//  Created by Amr Hesham on 1/9/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit
import WebKit
class DetailedViewController: UIViewController {
    var webView:WKWebView!
    var detailedItem:Petition?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        view = webView
        guard let detailedItem = detailedItem else {return}
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; }</style>
        </head>
        <body>
        \(detailedItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
