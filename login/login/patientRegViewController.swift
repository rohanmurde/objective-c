//
//  patientRegViewController.swift
//  login
//
//  Created by Rohan Murde on 8/7/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class patientRegistration: UIViewController{
    
    let regToReadSegue = "pRegToPReadingsSegue";
    
    @IBOutlet weak var pFN: UITextField!
    @IBOutlet weak var pLN: UITextField!
    @IBOutlet weak var pAge: UITextField!
    @IBOutlet weak var pSex: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!;
    
    var patientFN: String = "";
    var patientLN: String = "";
    var patientAge: Int = 0;
    var patientSex: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("Inside patientRegViewController....");
        
        pFN.text = ""
        pLN.text = ""
        pAge.text = ""
        pSex.text = ""
        
    }
    
    @IBAction func submitPressed(sender: AnyObject) {
        
        self.activityIndicator.startAnimating();
        patientFN = pFN.text!
        patientLN = pLN.text!
        patientAge = Int(pAge.text!)!
        patientSex = pSex.text!
        
//        print(patientFN, patientLN, patientAge, patientSex);
        
        let myUrl = NSURL(string: "http://localhost/insertPatientDetails.php") //Inserts a record in the mySQL database.
        let request = NSMutableURLRequest(URL: myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "patientFN="+String(patientFN)+"&patientLN="+String(patientLN)+"&patientAge="+String(patientAge)+"&patientSex="+String(patientSex);
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){(data, response, error) in
            
            if error != nil{
                self.activityIndicator.stopAnimating();
                print("error=\(error)")
                return
            }
            
            //                print("*** response=\(response)")
            
            do{
                //                    print("in do")
                
                if let json : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary{
                    //                    print("JSON data = \(json)")
                    let resultValue = json["status"] as? String
                    //                    print("Status= \(resultValue)")
                    
                    var isPatientRegistered:Bool = false;
                    if(resultValue == "Success"){
                        isPatientRegistered = true;
                        
                    }
                    
                    var messageToDisplay: String = json["message"] as! String;
                    if(!isPatientRegistered){
                        messageToDisplay = json["message"] as! String;
                    }
                    
                    print("###pReg=\(isPatientRegistered)");
                    dispatch_async(dispatch_get_main_queue(), {
                        let okAction: UIAlertAction;
                        //Display alert message with confirmation.
                        let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                        
                        if(isPatientRegistered){
                            okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                                self.activityIndicator.stopAnimating();
                                //                            self.performSegueWithIdentifier(self.submitSegue, sender: nil)
                                self.performSegueWithIdentifier(self.regToReadSegue, sender: nil)
                            }
                        }else{
                            okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                                self.activityIndicator.stopAnimating();
                                
                                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("patientRegistration") as UIViewController
                                self.presentViewController(vc, animated: false, completion: nil)
                            
                                self.pFN.text! = ""
                                self.pLN.text = ""
                                self.pAge.text = ""
                                self.pSex.text = ""
                            }
                            
                        }
                        
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        
                        
                    });
                    
                }
            }catch let error as NSError {
                self.activityIndicator.stopAnimating();
                print("in catch")
                print(error.localizedDescription)
            }
        }
        
        task.resume();
        
        
        
    }
    @IBAction func clearPressed(sender: AnyObject) {
        pFN.text = ""
        pLN.text = ""
        pAge.text = ""
        pSex.text = ""
    }
}
