//
//  DocumentViewController.swift
//  AtoCash
//
//  Created by user on 27/04/21.
//

import UIKit
import WebKit
class DocumentViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    @IBOutlet weak var loadPageView: UIView!
    var webview = WKWebView()
    var chatButton: Bool = false
    var chatURL : String?
    @IBOutlet weak var imageScrollView: ImageScrollView!
    @IBOutlet weak var imagePageView: UIView!
    var isImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imageScrollView.setup()
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backAction))
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
        self.loadPageView.isHidden = true
        self.imagePageView.isHidden = true
        
        if isImage{
            self.imagePageView.isHidden = false
            guard let url = URL(string: chatURL!)else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self!.imageScrollView.display(image: image)
                        }
                    }
                }
            }
        }
        else{
            self.loadPageView.isHidden = false
                if UtilsManager.isNetworkReached {
                    self.networkChange()
                }
                else{
                    AppDelegate.shared.presentNoInternetViewController { (connection) in
                        if(UtilsManager.isNetworkReached)
                        {
                            self.networkChange()
                        }
                    }
                }
        
            HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            
            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    #if DEBUG
                    print("WKWebsiteDataStore record deleted:", record)
                    #endif
                }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        setupUI()
    }
    
    private func setupUI(){
        self.title = NSLocalizedString("document_preview", comment: "")
    }
    
    private func networkChange(){
        self.loadWebpageURL(chatURL!)
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.webview.frame = self.loadPageView.bounds
        self.loadPageView.addSubview(self.webview)
        self.webview.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadWebpageURL(_ url : String){
        let link = URL(string:url)!
        let request = URLRequest(url: link)
        self.webview.load(request)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       
        if navigationAction.targetFrame == nil {
            
            webView.load(navigationAction.request)
        }
        if navigationAction.request.url?.scheme == "file"
        {
            decisionHandler(.allow)
        }
        else{
            decisionHandler(.allow)
        }
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        //Show progress bar
        showLoader()
        //MBProgressHUD.showAdded(to: AppDelegate.shared.window!, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Hide progress bar
        hideLoader()
        //MBProgressHUD.hide(for: AppDelegate.shared.window!, animated: true)
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
