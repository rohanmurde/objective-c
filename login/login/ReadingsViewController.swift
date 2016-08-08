//
//  ReadingsViewController.swift
//  login
//
//  Created by Rohan Murde on 1/2/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class ReadingsViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!;
    @IBOutlet weak var att1TextField: UITextField!
    @IBOutlet weak var att2TextField: UITextField!
    @IBOutlet weak var att3TextField: UITextField!
    @IBOutlet weak var att4TextField: UITextField!
    @IBOutlet weak var att5TextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    
    var att1: Float = 0.0
    var att2: Float = 0.0
    var att3: Float = 0.0
    var att4: Float = 0.0
    var att5: Float = 0.0
    
    var className: String = " "
    
    @IBAction func logoutAction(sender: AnyObject){
        self.loginSetup();
        
        
    }
    

    func loginSetup(){
        let vc : AnyObject! = self.storyboard?.instantiateInitialViewController()
        self.presentViewController(vc as! UIViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Inside SignUpViewController....");
        att1TextField.text = "";
        att2TextField.text = "";
        att3TextField.text = "";
        att4TextField.text = "";
        att5TextField.text = "";
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitReadingsPressed(sender: AnyObject) {
        
        self.activityIndicator.startAnimating();
      att1 = Float(att1TextField.text!)!
      att2 = Float(att2TextField.text!)!
        att3 = Float(att3TextField.text!)!
        att4 = Float(att4TextField.text!)!
        att5 = Float(att5TextField.text!)!
        
        print(att1 ,att2 ,att3 ,att4 ,att5)
//        let myUrl = NSURL(string: "http://localhost/welcome.php")
        let myUrl = NSURL(string: "http://localhost/insertRecord.php") //Inserts a record in the mySQL database.
        
        let request = NSMutableURLRequest(URL: myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "att1="+String(att1)+"&att2="+String(att2)+"&att3="+String(att3)+"&att4="+String(att4)+"&att5="+String(att5);
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            
            if error != nil{
                self.activityIndicator.stopAnimating();
                print("error=\(error)")
                return
                
            }
            
//            print("*** response=\(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("@@@@ response data = \(responseString!)")
            
            do {
//                print("in do")
                if let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
//                  print("JSON data = \(jsonResult)")
                    // Get value by key
                    let attribute1 = jsonResult["className"] as? String
                    print("ClassRecognition = \(attribute1!)")
                    
                    if(attribute1! == "[0]\n"){
                        self.className = "AD"
                    }
                    else if(attribute1! == "[1]\n"){
                        self.className = "MCI"
                    }
                    else if(attribute1! == "[2]\n"){
                        self.className = "NL"
                    }
                    else{
                        self.className = "XX"
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.classNameTextField.text =  self.className
                        self.activityIndicator.stopAnimating();
                    })

                    
                    }
                    
                
            } catch let error as NSError {
//                print("in catch")
                print(error.localizedDescription);
                self.activityIndicator.stopAnimating();
            }
            
        }
        
        task.resume()
        
        
    }
   
    @IBAction func clearPressed(sender: AnyObject) {
        att1TextField.text = "";
        att2TextField.text = "";
        att3TextField.text = "";
        att4TextField.text = "";
        att5TextField.text = "";
    }
}

