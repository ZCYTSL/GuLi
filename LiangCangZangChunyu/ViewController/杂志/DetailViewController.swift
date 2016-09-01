//
//  DetailViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIWebViewDelegate {
    var webView: UIWebView!
    var model = MagazineModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatWebView()
        
    }
    func creatWebView() -> Void {
        webView = UIWebView.init(frame: self.view.bounds)
        webView.delegate = self
        let urlStr = model.access_url
        let url = NSURL.init(string: urlStr)
        let request = NSURLRequest.init(URL: url!)
        webView.loadRequest(request)
        self.view.addSubview(webView)
        
    }
    func webViewDidStartLoad(webView: UIWebView) {
        HDManager.startLoading()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        HDManager.stopLoading()
    }


}
