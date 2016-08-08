//
//  ViewController.swift
//  login
//
//  Created by Rohan Murde on 1/1/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let ReadingsSegue = "LoginSuccesful"
    let SignUpSegue = "SignUpSegue"
    let patientSegue = "loginToPatientSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside Login View Controller....");
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
//        performSegueWithIdentifier(scrollViewWallSegue, sender: nil)
        
        
        
        /*
        PFUser.logInWithUsernameInBackground(userTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                
                print("Login Successful....");
                self.performSegueWithIdentifier(self.ReadingsSegue, sender: nil)
                
            } else {
                print("Login Error....");
                
                let alertController = UIAlertController(title: "Login Failed", message:
                    "Incorrect Credentials !", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                self.userTextField.text = ""
                self.passwordTextField.text = ""
                
            }
        }*/
        self.activityIndicator.startAnimating();
        let userUserName = userTextField.text!;
        let userPassword = passwordTextField.text!;
        
        // Check for empty fields
        if(userUserName.isEmpty || userPassword.isEmpty){
            self.activityIndicator.stopAnimating();
            displayAlertMessage("All fields are required.");
            return;
        }
        else{
            
//            print("Inside VC Else ....");
            
            let myUrl = NSURL(string: "http://localhost/userLogin.php") //Inserts a record in the mySQL database.
            
            let request = NSMutableURLRequest(URL: myUrl!);
            request.HTTPMethod = "POST";
            
            //            let postString = "firstName=\(userFirstName!)&lastName=\(userLastName!)&userName=\(userUserName!)&password=\(userPassword!)";
            let postString = "userName="+String(userUserName)+"&password="+String(userPassword);
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
//                        print(resultValue);
                        var isUserRegistered:Bool = false;
                        if(resultValue == "Success"){
                            isUserRegistered = true;
                            
                        }
                        
                        var messageToDisplay: String = json["message"] as! String;
                        if(!isUserRegistered){
                            messageToDisplay = json["message"] as! String;
                        }
                        
                        //                    print("###\(isUserRegistered)");
                        dispatch_async(dispatch_get_main_queue(), {
                            let okAction: UIAlertAction;
                            //Display alert message with confirmation.
                            let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                            
                            if(isUserRegistered){
                                okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                                    self.activityIndicator.stopAnimating();
//                                    self.performSegueWithIdentifier(self.ReadingsSegue, sender: nil)
                                    self.performSegueWithIdentifier(self.patientSegue, sender: nil)
                                }
                            }else{
                                okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                                    self.activityIndicator.stopAnimating();
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                                    let vc : UIViewController = mainStoryboard.instantiateInitialViewController()! as UIViewController
                                    self.presentViewController(vc, animated: false, completion: nil)
                                    self.passwordTextField.text = ""
                                    self.userTextField.text = ""
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
        
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Login Failed", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(sender: AnyObject) {
        print("SignUp Pressed....");
//     self.performSegueWithIdentifier(self.SignUpSegue, sender: nil)
    }


}

