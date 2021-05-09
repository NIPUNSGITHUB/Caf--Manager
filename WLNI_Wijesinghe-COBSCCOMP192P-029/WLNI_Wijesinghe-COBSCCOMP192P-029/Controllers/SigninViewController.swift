//
//  SigninViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 5/8/21.
//

import UIKit
import Firebase
class SigninViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnSigninui: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                txtEmail.text = "iosnipun9@gmail.com";
                txtPwd.text = "12345678"
               // txtPwd.text = "nip123456"
        btnSigninui.layer.cornerRadius = 10.0;
        // Do any additional setup after loading the view.
    }
    
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
            let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
            self.present(alert, animated: true)
            let deadlineTime = DispatchTime.now() + .seconds(delay)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
    }
     
    
    @IBAction func btnSignin(_ sender: Any) {
        
        
          if txtEmail.text == ""
          {
              Toast(Title: "Information", Text: "Please enter your email address", delay: 1)
          }
          else if(txtPwd.text == "")
          {
              Toast(Title: "Information", Text: "Please enter your password", delay: 1)
          }
          else
          {
              var email = txtEmail.text!;
              var password = txtPwd.text!;
              
              Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error as? NSError {
                  switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed: break
                    self.Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                    // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                  case .userDisabled: break
                    self.Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                    // Error: The user account has been disabled by an administrator.
                  case .wrongPassword: break
                    self.Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                    // Error: The password is invalid or the user does not have a password.
                  case .invalidEmail: break
                    self.Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                    // Error: Indicates the email address is malformed.
                  default:
                    self.Toast(Title: "Information", Text: error.localizedDescription, delay: 1)
                    
                  }
                } else {
                  print("User signs in successfully")
                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                  let vc = UIViewController()
                  vc.modalPresentationStyle = .fullScreen
                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! HomeViewController
                  self.present(nextViewController, animated:true, completion:nil)
  //                let userInfo = Auth.auth().currentUser
  //                let email = userInfo?.email
                 
                }
              }
              
        }
        
    }
     

}
