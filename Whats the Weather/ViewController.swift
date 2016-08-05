//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Muhammad Usman on 05/08/2016.
//  Copyright © 2016 Muhammad Usman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var city: UITextField!

   
    @IBAction func button(sender: AnyObject)
    {
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + city.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") +  "/forecasts/latest")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url)
        { (data, response, error) in
            if let urlContent = data
            {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                //print(webContent)
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray!.count > 1
                {
                    let weatherArray = websiteArray![1].componentsSeparatedByString("<")
                    if weatherArray.count > 1
                    {
                        let status = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        dispatch_async(dispatch_get_main_queue(), {
                            self.result.text = status
                        })
                        
                    }
                }
                
                
            }
        }
        
        
        task.resume()

        
    }
    
    
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

