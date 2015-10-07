//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Luiz Fernando Santiago on 10/6/15.
//  Copyright © 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func showTheWeather(sender: AnyObject) {
        
        var wasSuccessful = false
    
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl{
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webSiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if webSiteArray.count > 1{
                    
                    let weatherArray = webSiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultLabel.text = weatherSummary
                            //self.resultLabel.textColor = UIColor.redColor()
                            
                        })
                        
                    }
                    
                }
                
                if wasSuccessful == false{
                
                    self.resultLabel.text = "Couldnt find this city please try again"
                }
            }
            
        }
        
        task.resume()
        } else {
        
            self.resultLabel.text = "Couldnt find this city please try again"
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    
    
    
    }


}

