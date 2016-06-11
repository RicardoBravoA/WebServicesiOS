//
//  ViewController.swift
//  WebServicesDemo
//
//  Created by Ricardo Bravo Acuña on 11/06/16.
//  Copyright © 2016 Ricardo Bravo Acuña. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        loadWS()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWS(){
    
        let apiUrl = "http://creating-solutions.net/ecommerceapi/v1/brand/"
        let url = NSURL(string: apiUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if(error != nil){
                print(error!.localizedDescription)
            }else{
                let nsData:NSData = NSData(data: data!)
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(nsData, options: NSJSONReadingOptions.MutableContainers)
                    
                    print("json completo \(json)")
                    
                    let meta = json["_meta"]
                    print("meta \(meta!)")
                    
                    if let nsMeta = meta! as? NSObject {
                        let code = nsMeta.valueForKey("code")
                        let status = nsMeta.valueForKey("status")
                        print("code \(code!)")
                        print("status \(status!)")
                    }else{
                        print("error meta")
                    }
                    
                    let data = json["data"]

                    print("data \(data!)")
                    
                    if let nsData = data! as? NSArray{
                        
                        for(index, object) in nsData.enumerate(){
                            if let nsObject = object as? NSObject {
                                let brandId = nsObject.valueForKey("brand_id")
                                let description = nsObject.valueForKey("description")
                                
                                print("\(index) - \(brandId!) \(description!)")
                            }
                        }
                    
                    }
                
                    
                    /*
                    dispatch_async(dispatch_get_main_queue(), {
                    
                        self.lbl.text = json as? String
                        
                    })
                    */
                    
                    

                    
                }catch{
                    print("error")
                }
                
            }
        }
        task.resume()
    
    }


}

