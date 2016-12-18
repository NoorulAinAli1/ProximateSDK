//
//  URLCampaignActionViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class URLCampaignActionViewController: BaseViewController, UIWebViewDelegate {
    var mCampaignAction : ObjectCampaignAction!
    @IBOutlet var webView : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor

        self.title = mCampaignAction.actionTitle

        self.webView.loadRequest(NSURLRequest(URL: mCampaignAction.getURL()))
//        let url = NSURL (string: "http://www.google.com");
//        let requestObj = NSURLRequest(URL: url!);
//        self.webView.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        DebugLogger.debugLog("webViewDidStartLoad")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        DebugLogger.debugLog("didFailLoadWithError")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        DebugLogger.debugLog("webViewDidFinishLoad")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
