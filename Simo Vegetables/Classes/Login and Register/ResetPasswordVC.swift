//
//  ResetPasswordVC.swift
//  InitialWork
//
//  Created by Gunjan on 03/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import TextFieldEffects
//import KOLocalizedString

class ResetPasswordVC: ParentClass,UITextFieldDelegate {
    
    
    @IBOutlet weak var txt_password: MyTextfiled!
    @IBOutlet weak var txt_confirmPassword: MyTextfiled!
    @IBOutlet weak var txt_oldPassword: MyTextfiled!
    
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var blurview: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    var fromWhere : String! = ""
    var type : String! = ""

    @IBOutlet weak var imgOldpassword: UIImageView!
    @IBOutlet weak var imgNewPassword: UIImageView!
    @IBOutlet weak var imgConfirmNewPassword: UIImageView!

    @IBOutlet weak var oldViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewOldpassword: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgOldpassword.setImageColor(color: colorPrimary)
        imgNewPassword.setImageColor(color: colorPrimary)
        imgConfirmNewPassword.setImageColor(color: colorPrimary)

        txt_password.delegate = self
        txt_confirmPassword.delegate = self
        MadokaTextField.appearance().tintColor = .white
        self.btn_submit.layer.cornerRadius = self.btn_submit.frame.size.height/2
        self.blur.clipsToBounds = true;
        self.blur.layer.cornerRadius = self.blur.frame.size.height/2
        
        if fromWhere == "reset" || fromWhere == "login"{
            type = "reset"
            viewOldpassword.isHidden = true
            oldViewHeight.constant = 0.0
        }
      
        // Do any additional setup after loading the view.
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - API Function
    //––––––––––––––––––––––––––––––––––––––––
    ///  Base settings localized  elements on area view controller
    
    func apiCallingFuncation(){
        
        WebServicesManager.RESET_PASSWORD_WS(mobile: ConnflixUtilities.shared.mobile!, password: txt_password.text!.trim() ,onCompletion: { response in
            if response!["success"].intValue == 1 {

            if self.fromWhere == "reset"{
                if response!["success"].intValue == 1 {
                    self.navigationController?.pushViewController(ParentClass.sharedInstance.customBouncesStyle(), animated: true)
                } else {
                    self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
                }
            }else if self.fromWhere == "login"{
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CS.Identifiers.LoginVC) as? LoginVC {
                    if let navigator = self.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }else{
                self.showAlert(message: response!["message"].stringValue, type: AlertType.success, navBar: false)
            }
            }else{
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        },onError:{ error in
            
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
            
        })
        
//           self.navigationController?.pushViewController(ParentClass.customBouncesStyle(), animated: true)
    }
    
    
    private func validateFields() -> Bool {
        
        let validation = Validation()
        
        
        if (!self.txt_oldPassword.notEmpty() || !validation.isValidPassword(Password: (txt_oldPassword.text?.trim())!)) && self.viewOldpassword.isHidden == false  {
            self.showAlert(message: CS.Login.invalidOldPasswrod, type: AlertType.error, navBar: false)
            return false
        }
        if !self.txt_password.notEmpty() || !validation.isValidPassword(Password: (txt_password.text?.trim())!) {
            self.showAlert(message: CS.Login.invalidpasswrod, type: AlertType.error, navBar: false)
            return false
        }
        if !self.txt_confirmPassword.notEmpty() || !validation.isValidPassword(Password: (txt_confirmPassword.text?.trim())!) {
            self.showAlert(message:  CS.Login.invalidConfirmpasswrod, type: AlertType.error, navBar: false)
            return false
        }
        
        if  txt_confirmPassword.text?.trim() != txt_password.text?.trim() {
            self.showAlert(message:  CS.Login.ConfrimPasswrod, type: AlertType.error, navBar: false)
            return false
        }
        
        
        
        return true
    }
    // ----------------------------------------------------------
    //MARK:- Action method
    // ----------------------------------------------------------
    
    @IBAction func OnSubmitPressed(_ sender: Any)
    {
        
        if validateFields() {
            apiCallingFuncation()
        }

    }
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // ----------------------------------------------------------
    //MARK:- TextField Method
    // ----------------------------------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txt_password{
            txt_confirmPassword.becomeFirstResponder()
        }
        else if textField == txt_confirmPassword{
            txt_confirmPassword.resignFirstResponder()
        }
        return false

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
