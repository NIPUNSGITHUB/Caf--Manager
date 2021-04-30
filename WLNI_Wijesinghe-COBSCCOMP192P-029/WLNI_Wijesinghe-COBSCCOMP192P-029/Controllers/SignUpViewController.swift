//
//  SignUpViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/30/21.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "iosnipun9@gmail.com";
        txtPwd.text = "nip123456"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSignUp(_ sender: Any) {
      
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
                  // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                case .userDisabled: break
                  // Error: The user account has been disabled by an administrator.
                case .wrongPassword: break
                  // Error: The password is invalid or the user does not have a password.
                case .invalidEmail: break
                  // Error: Indicates the email address is malformed.
                default:
                    print("Error: \(error.localizedDescription)")
                }
              } else {
                print("User signs in successfully")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = UIViewController()
                vc.modalPresentationStyle = .fullScreen 
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! ItemListViewController
                self.present(nextViewController, animated:true, completion:nil)
//                let userInfo = Auth.auth().currentUser
//                let email = userInfo?.email
               
              }
            }
            
        }
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
