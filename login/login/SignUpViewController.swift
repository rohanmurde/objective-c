//
//  Sign Up View Controller.swift
//  login
//
//  Created by Rohan Murde on 1/2/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

//class SignUpViewController: UIViewController {
//    
//
//    
//    @IBOutlet weak var userTextField: UITextField!
//    
//    @IBOutlet weak var passwordTextField: UITextField!
//    
//    @IBOutlet weak var ReEnterPasswordTextField: UITextField!
//
//    let submitSegue = "submitSegue"
//    
//    @IBAction func submitPressed(sender: AnyObject) {
//        //1
//        let user = PFUser()
//        
//        //2
//        user.username = userTextField.text
//        user.password = passwordTextField.text
//        
//        //3
//        
//        if(userTextField.text!.isEmpty || passwordTextField.text!.isEmpty || ReEnterPasswordTextField.text!.isEmpty){
//            
//
//            let alertController = UIAlertController(title: "Sign Up Failed", message:
//                "All fields are mandatory", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        else if(passwordTextField.text != ReEnterPasswordTextField.text){
//            
//            let alertController = UIAlertController(title: "Sign Up Failed", message:
//                "Passwords Don't Match !", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        else{
//            
//            user.signUpInBackgroundWithBlock { succeeded, error in
//                if (succeeded) {
//                    //The registration was successful, go to the wall
//                    self.performSegueWithIdentifier(self.submitSegue, sender: nil)
//                } else {
//                    //Something bad has occurred
//                    print("SignUp Error....");
//                    
//                    let alertController = UIAlertController(title: "Sign Up Failed", message:
//                        "Username already exists !", preferredStyle: UIAlertControllerStyle.Alert)
//                    
//                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                    
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//        
//    }

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ReEnterPasswordTextField: UITextField!
    
    let submitSegue = "submitSegue"
    let SignUpSegue = "SignUpSegue"
    let patientSegue = "signUpToPatientSegue"
    
    @IBAction func submitPressed(sender: AnyObject) {
        
        self.activityIndicator.startAnimating();
        let userFirstName = firstNameTextField.text!;
        let userLastName = lastNameTextField.text!;
        let userUserName = userTextField.text!;
        let userPassword = passwordTextField.text!;
        let userReEnterPassword = ReEnterPasswordTextField.text!;
        
        // Check for empty fields
        if(userUserName.isEmpty || userPassword.isEmpty || userReEnterPassword.isEmpty || userFirstName.isEmpty || userLastName.isEmpty){
            self.activityIndicator.stopAnimating();
            displayAlertMessage("All fields are required.");
            return;
        }
            
        //Check if passwords match
        else if(userPassword != userReEnterPassword){
            self.activityIndicator.stopAnimating();
            displayAlertMessage("Passwords Don't Match !");
            return;
        }
            
        //Store data in the database
        else{
            
            print("Inside SignUp Else ....");
            
            let myUrl = NSURL(string: "http://localhost/userSignUp.php") //Inserts a record in the mySQL database.
            
            let request = NSMutableURLRequest(URL: myUrl!);
            request.HTTPMethod = "POST";
            
//            let postString = "firstName=\(userFirstName!)&lastName=\(userLastName!)&userName=\(userUserName!)&password=\(userPassword!)";
            let postString = "firstName="+String(userFirstName)+"&lastName="+String(userLastName)+"&userName="+String(userUserName)+"&password="+String(userPassword);
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
//                            self.performSegueWithIdentifier(self.submitSegue, sender: nil)
                            self.performSegueWithIdentifier(self.patientSegue, sender: nil)
                        }
                        }else{
                            okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                                self.activityIndicator.stopAnimating();
                                self.dismissViewControllerAnimated(true, completion: nil)
                                self.firstNameTextField.text! = ""
                                self.passwordTextField.text = ""
                                self.userTextField.text = ""
                                self.lastNameTextField.text = ""
                                self.ReEnterPasswordTextField.text = ""
                                
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
        let myAlert = UIAlertController(title: "Sign Up Failed", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Inside SignUpViewController....");

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


