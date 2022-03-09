//
//  WebKitViewController.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 04/03/22.
//

import UIKit
import SafariServices
import WebKit
class WebKitViewController: UIViewController {
    @IBOutlet weak var webnit : WKWebView!
    var url : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url!)
        webnit.load(URLRequest(url: url!))
        
    }
    
    @IBAction func bacBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
