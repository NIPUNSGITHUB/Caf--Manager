//
//  SignUpViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnsignupui: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var txtRPwd: UITextField!
    private let db = Database.database().reference();
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.text = "NipunIshara"
        txtPhoneNo.text = "0714747489"
        txtRPwd.text = "nip123456"
        txtEmail.text = "iosnipun9@gmail.com";
        txtPwd.text = "nip123456"
        btnsignupui.layer.cornerRadius = 10.0;
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSignUp(_ sender: Any) {
      
        if txtUsername.text == "" {
            Toast(Title: "Information", Text: "Please enter your name", delay: 1)
        }
        else if txtEmail.text == ""
        {
            Toast(Title: "Information", Text: "Please enter your email address", delay: 1)
        }
        else if isValidEmail(email: txtEmail.text!) == false
        {
            Toast(Title: "Information", Text: "Please enter valid email address", delay: 1)
        }
        else if (txtPhoneNo.text == "" || (txtPhoneNo.text?.count != 10) || isValidPhone(phone: txtPhoneNo.text!) == false)
        {
            Toast(Title: "Information", Text: "Please enter valid phone number", delay: 1)
        }
        else if(txtPwd.text == "" || txtRPwd.text == "")
        {
            Toast(Title: "Information", Text: "Please enter your password", delay: 1)
        }
        else if(txtPwd.text!.count < 6)
        {
            Toast(Title: "Information", Text: "The password must be 6 characters long or more.", delay: 1)
        }
        else if(txtPwd.text != txtRPwd.text)
        {
            Toast(Title: "Information", Text: "Re enter your password.", delay: 1)
        }
        else
        {
            var email = txtEmail.text!;
            var password = txtPwd.text!;
            
            Auth.auth().createUser(withEmail: email, password:password)
            { [self] (authResult, error) in
             if let error = error as? NSError {
               switch AuthErrorCode(rawValue: error.code) {
               case .operationNotAllowed: break
                 // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
               case .userDisabled: break
                 // Error: The user account has been disabled by an administrator.
               case .wrongPassword: break
                 // Error: The password is invalid or the user does not have a password.
               case .invalidEmail: break
                 // Error: Indicates the email address is malformed.
               default:
                Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                   //print("Error: \(error.localizedDescription)")
               }
             } else {
                saveUserDetails(email: txtEmail.text!, username:txtUsername.text!, phoneNo: txtPhoneNo.text!)
                
               //print(authResult)
             }
           }
            
        }
    }
    
    func saveUserDetails(email:String,username:String,phoneNo:String){
        let group = DispatchGroup()
        let child = UUID().uuidString
        self.db.child("Users").child(child).child("username").setValue(username);
        self.db.child("Users").child(child).child("email").setValue(email);
        self.db.child("Users").child(child).child("phoneNo").setValue(phoneNo);
        group.wait()
    
        group.notify(queue: .main) {
                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let vc = UIViewController()
                           vc.modalPresentationStyle = .fullScreen
                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! HomeViewController
                           self.present(nextViewController, animated:true, completion:nil)
        
        }
    }
    
   
   
    
    func isValidPhone(phone: String) -> Bool {
//        +1994423565 - Valid
//        ++1994423565 - Invalid
//        01994423565 - Valid
//        001994423565 - Valid
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }

    func isValidEmail(email: String) -> Bool {
//        something@example.com - Valid
//        something@.com - Invalid
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
            let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
            self.present(alert, animated: true)
            let deadlineTime = DispatchTime.now() + .seconds(delay)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        }
     
    
}
