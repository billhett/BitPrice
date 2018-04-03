//
//  InterfaceController.swift
//  BitPrice WatchKit Extension
//
//  Created by William Hettinger on 4/2/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var bitcoinPriceLabel: WKInterfaceLabel!
    var bitcoinPrice = "Updating..."
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadScreen()

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadScreen()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func loadScreen() {
        //        let url = NSURL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")
        //        let request = NSURLRequest(url: url! as URL)
        //        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.mainQueue()) {(response, data, error) -> Void in
        //
        //        NSURLConnection.
        //        }
        var request = URLRequest(url: URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!)
        //        request.httpMethod = "POST"
        //        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            print("###########################################################################")
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String : AnyObject]
                print(json)
                let fullDictionary = json["bpi"] as! [String : AnyObject]
                let usdDictionary = fullDictionary["USD"] as! [String : AnyObject]
                
                //let dollarPrice = json["rate"]
                print("US dollar price is : \(fullDictionary)")
                self.bitcoinPrice = (usdDictionary["rate"]! as! String)
            } catch {
                print("error")
            }
            self.bitcoinPriceLabel.setText(self.bitcoinPrice)
            
            
        })
        
        task.resume()
        
    }
}
