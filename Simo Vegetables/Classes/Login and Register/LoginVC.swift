//
//  LoginVC.swift
//  InitialWork
//
//  Created by Gunjan on 19/02/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import TextFieldEffects
//import KOLocalizedString
import CountryPickerView
//import GoogleSignIn
//import FBSDKCoreKit
//import FBSDKLoginKit


class LoginVC: ParentClass ,UITextFieldDelegate,CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print(country.name)
//        ConnflixUtilities.shared.countryCode = country.phoneCode
     }
    
    // ----------------------------------------------------------
    // MARK: IB Outlets
    // ----------------------------------------------------------
   
    @IBOutlet weak var txt_User: MyTextfiled!
    @IBOutlet weak var txt_CountryCode: CountryTextfiled!
    @IBOutlet weak var txt_Password: MyTextfiled!
    @IBOutlet weak var btn_Login: UIButton!
    @IBOutlet weak var btn_check: UIButton!
    @IBOutlet weak var LNbutton: UIBarButtonItem!
    @IBOutlet weak var termCondition: ThemeColorButton!
    @IBOutlet weak var ORlabel: ThemeColorButton!
    @IBOutlet weak var Forgotpassword: UIButton!

    @IBOutlet weak var imgMobile: UIImageView!
    @IBOutlet weak var imgPassword: UIImageView!


    @IBOutlet weak var btn_signup: ThemeColorButton!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    weak public var dataSource: CountryPickerViewDataSource?
    weak public var delegate: CountryPickerViewDelegate?
    
    
    // ----------------------------------------------------------
    //MARK:- Viewload
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
//        Hud.showLoading(title: "Please wait")
        imgMobile.setImageColor(color: colorPrimary)
        imgPassword.setImageColor(color: colorPrimary)
        self.navigationController?.navigationBar.barTintColor = THEME_COLOR

        self.btn_Login.layer.cornerRadius = self.btn_Login.frame.size.height/2

        txt_User.delegate = self
        txt_Password.delegate = self
        MadokaTextField.appearance().tintColor = .white
        txt_User.text = "9016493160"
        txt_Password.text = "admin@123"
//        setupCountryPicker()
        UDID =  KeychainManager() .getDeviceIdentifierFromKeychain()
        print(UDID)
//        28381D03-B91F-4FE7-A3A6-EAE8AF2F2E53
//        28381D03-B91F-4FE7-A3A6-EAE8AF2F2E53
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - API Function
    //––––––––––––––––––––––––––––––––––––––––
   
    func apiCallingFuncation(){
        
        
        WebServicesManager .loginWS(mobile: txt_User.text!.trim(), password: txt_Password.text!.trim(),view:self.view, onCompletion: { response in
            
            if response!["success"].intValue == 1 {
                
                let userData = User.init(fromJson: response!["admin"])
                ConnflixUtilities.shared.mobile = userData.mobile
                ConnflixUtilities.shared.UserID = userData.userId
                ConnflixUtilities.shared.email = userData.email
                ConnflixUtilities.shared.profilePic = userData.profilePic
                ConnflixUtilities.shared.firstname = userData.firstName
                ConnflixUtilities.shared.lastname = userData.lastName
                ConnflixUtilities.shared.lastname = userData.lastName
                ParentClass.sharedInstance.saveJSON(json:response!["admin"] , key: CS.Saved.userData)

                self.navigationController?.pushViewController(ParentClass.sharedInstance.customBouncesStyle(), animated: true)
            } else {
                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
            
        },onError:{ error in
            
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
            
        })
        
        
    }


//    ––––––––––––––––––––––––––––––––––––––––
    //MARK: - Actions -
    //––––––––––––––––––––––––––––––––––––––––
    /// Function for change localization
    @IBAction func Onpressd(_ sender: UIBarButtonItem) {
//          OnLanguagePressed()
//        KOSetLanguage.Login((LNbutton != nil) ? "hi":"en")
//          registerNotifications()
    }
    
    @IBAction func OnForgotPasswordpressd(_ sender: UIButton) {
        
        let ForgotPassword = EditProfileViewController()
        self.navigationController?.pushViewController(ForgotPassword, animated: true)
    
    }
    // ----------------------------------------------------------
    //MARK:- validation method
    // ----------------------------------------------------------
    
    private func validateFields() -> Bool {
        
        let validation = Validation()
        
        if !self.txt_User.notEmpty() || txt_User.text!.count < 10 {
            self.showAlert(message:  CS.Login.invalidMobile, type: AlertType.error, navBar: false)
            return false
        }
        
//        if !self.txt_Password.notEmpty() || !validation.isValidPassword(Password: txt_Password.text!.trim()){
//            self.showAlert(message:  CS.Login.invalidpasswrod, type: AlertType.error, navBar: false)
//            return false
//        }
        
        if btn_check.isSelected != true{
//            self.show-Alert(message:  CS.Login.Terms, type: AlertType.error, navBar: false)
        }
    
        return true
    }
    
//     ----------------------------------------------------------
    //MARK:- Action method
    // ----------------------------------------------------------

    @IBAction func OnSubmitPressed(_ sender: Any)
    {
//        self.navigationController?.pushViewController(ParentClass.customBouncesStyle(), animated: true)
//        return;
        if validateFields(){
          apiCallingFuncation()
        }
    }
   
    
    @IBAction func OnTCPressed(_ sender: UIButton) {

        btn_check.isSelected = !btn_check.isSelected
    }
    
    // ----------------------------------------------------------
    //MARK:- TextField Method
    // ----------------------------------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txt_User
        {
            txt_User.resignFirstResponder()
            txt_Password.becomeFirstResponder()
        }
        else{
//            self.OnSubmitPressed(self)
            txt_Password.resignFirstResponder()
        }
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
