//
//  ForgotPasswordViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 5/8/21.
//

import UIKit
import Firebase
class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var changepwdBtnUi: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changepwdBtnUi.layer.cornerRadius = 10.0;
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnChangePassword(_ sender: Any) {
        if txtEmail.text == ""
        {
            Toast(Title: "Information", Text: "Please enter your email address", delay: 1)
        }
        else if isValidEmail(email: txtEmail.text!) == false
        {
            Toast(Title: "Information", Text: "Please enter valid email address", delay: 1)
        }
        else{
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { [self] (action) in
            Auth.auth().sendPasswordReset(withEmail:txtEmail.text!) { error in
                if error != nil{
                              let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                              resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                              self.present(resetFailedAlert, animated: true, completion: nil)
                          }else {
                              let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                              resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                              self.present(resetEmailSentAlert, animated: true, completion: nil)
                          }
            }
         })) 
       
        self.present(forgotPasswordAlert, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
//        something@example.com - Valid
//        something@.com - Invalid
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
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
