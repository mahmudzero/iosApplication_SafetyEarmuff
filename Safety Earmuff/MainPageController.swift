//
//  MainPage.swift
//  Safety Earmuff
//
//  Created by Mahmud Ahmad on 2/19/18.
//  Copyright © 2018 Mahmud Ahmad. All rights reserved.
//

import Foundation
import UIKit

class MainPageController: UIViewController {
    @IBOutlet var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postAlertToServer(_ sender: Any) {
//        var url : NSURL = NSURL(String: "")!;
//        var request: NSMutableURLRequest = NSMutableURLRequest(url: url);
//        var data = "Manual Override";
//        request.httpMethod = "POST";
//        request.httpBody = bodyData.datausing
        
        let url = URL(string: "https://safety-earmuff.herokuapp.com/send-mail")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func updateAlertLabel() {
        if((alertLabel?.text as! String) == "Something happened") {
            alertLabel.text = "Nothing";
            print("Nothing");
        } else {
            print((alertLabel?.text as! String));
            alertLabel.text = "Something happened";
            print((alertLabel?.text as! String));
        }
    }
}

