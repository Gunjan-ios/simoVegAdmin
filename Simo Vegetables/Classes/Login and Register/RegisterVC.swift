//
//  RegisterVC.swift
//  InitialWork
//
//  Created by Gunjan on 21/02/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import TextFieldEffects
//import KOLocalizedString
import CountryPickerView

class RegisterVC: ParentClass,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       cuntryCode = country.phoneCode
//        ConnflixUtilities.shared.countryCode = cuntryCode
    }
    
    // ----------------------------------------------------------
    // MARK: IB Outlets
    // ----------------------------------------------------------
    
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var txt_firstname: MyTextfiled!
    @IBOutlet weak var txt_lastname: MyTextfiled!
    @IBOutlet weak var txt_email: MyTextfiled!
    @IBOutlet weak var txt_CountryCode: CountryTextfiled!
    @IBOutlet weak var txt_mobile: MyTextfiled!
    @IBOutlet weak var txt_Password: MyTextfiled!
    @IBOutlet weak var txt_ConfirmPassword: MyTextfiled!
    @IBOutlet weak var txt_referralCode: MyTextfiled!
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var btn_privacy: UIButton!
    @IBOutlet weak var blurview: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var BtnLogin: UIButton!
    
    weak public var dataSource: CountryPickerViewDataSource?
    weak public var delegate: CountryPickerViewDelegate?
    
    var cuntryCode : String!


    

    @IBOutlet weak var imgFirstName: UIImageView!
    @IBOutlet weak var imgLatName: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgMobilenumber: UIImageView!
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var imgConfrimPassword: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!





    override func viewDidLoad() {
        super.viewDidLoad()


        imgFirstName.setImageColor(color: colorPrimary)
        imgLatName.setImageColor(color: colorPrimary)
        imgEmail.setImageColor(color: colorPrimary)
        imgMobilenumber.setImageColor(color: colorPrimary)
        imgPassword.setImageColor(color: colorPrimary)
        imgConfrimPassword.setImageColor(color: colorPrimary)
        imgAddress.setImageColor(color: colorPrimary)

        txt_lastname.delegate = self
        txt_firstname.delegate = self
        txt_referralCode.delegate = self
        txt_Password.delegate = self
        txt_email.delegate = self
        txt_ConfirmPassword.delegate = self
        MadokaTextField.appearance().tintColor = .white
        self.btn_submit.layer.cornerRadius = self.btn_submit.frame.size.height/2
//        self.img_profile.layer.cornerRadius = self.img_profile.frame.size.height/2
        settings()
        self.blur.clipsToBounds = true;
        self.blur.layer.cornerRadius = self.blur.frame.size.height/2
        img_profile.isUserInteractionEnabled = true
        setupCountryPicker()
        
        UDID = KeychainManager() .getDeviceIdentifierFromKeychain().trim()
        print(UDID)

        // Do any additional setup after loading the view.
    }
    func setupCountryPicker(){
        let cpv = CountryPickerView(frame: CGRect(x: 8 , y: 0, width: txt_CountryCode.bounds.width, height: txt_CountryCode.bounds.height))
        txt_CountryCode.awakeFromNib()
        cpv.textColor = UIColor.white
        let country = cpv.selectedCountry
        cuntryCode = country.phoneCode
//        ConnflixUtilities.shared.countryCode = cuntryCode
        print(country)
        cpv.delegate = self
        cpv.dataSource = self
        cpv.showCountryCodeInView = true
        cpv.showCountryNameInView = true
        txt_CountryCode.addSubview(cpv)
//        cpv.showCountriesList(from:self)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Settings -
    //––––––––––––––––––––––––––––––––––––––––
    
    private func settings(){
        self.localizedSettings()
//        self.registerNotifications()
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Loclized Setting -
    //––––––––––––––––––––––––––––––––––––––––
    ///  Base settings localized  elements on area view controller
    private func localizedSettings()
    {
//        self.title = KOLocalizedString(Language.Login.SignUp)
//        self.txt_User.placeholder = KOLocalizedString(Language.Login.UserName)
//        self.txt_email.placeholder = KOLocalizedString(Language.Login.Email)
//        self.txt_Password.placeholder = KOLocalizedString(Language.Login.Password)
//        self.txt_mobile.placeholder = KOLocalizedString(Language.Login.Mobile)
//        self.txt_ConfirmPassword.placeholder = KOLocalizedString(Language.Login.ConfirmPassword)
//        self.btn_submit.setTitle(KOLocalizedString(Language.Login.Submit), for: .normal)
//        self.BtnLogin.setTitle(KOLocalizedString(Language.Login.alreday), for: .normal)
//        self.btn_privacy.setTitle(KOLocalizedString(Language.Login.TC), for: .normal)
        
    }
    private func validateFields() -> Bool {
        
        let validation = Validation()
        
        if !self.txt_firstname.notEmpty() || !validation.isValidName(name: txt_firstname.text!.trim()) {
            self.showAlert(message:  CS.Login.invalidFirstName, type: AlertType.error, navBar: false)
            return false
        }
        if !self.txt_lastname.notEmpty() || !validation.isValidName(name: txt_lastname.text!.trim()) {
            self.showAlert(message:  CS.Login.invalidLastName, type: AlertType.error, navBar: false)
            return false
        }
        
        if !self.txt_email.notEmpty() || !validation.isValidEmail(email: txt_email.text!.trim()) {
            self.showAlert(message:  CS.Login.invalidEmail, type: AlertType.error, navBar: false)
            return false
        }
        
        if !self.txt_Password.notEmpty() || !validation.isValidPassword(Password: txt_Password.text!.trim()){
            self.showAlert(message:  CS.Login.invalidpasswrod, type: AlertType.error, navBar: false)
            return false
        }
        
        if !self.txt_ConfirmPassword.notEmpty() || !validation.isValidPassword(Password: txt_ConfirmPassword.text!.trim()){
            self.showAlert(message:  CS.Login.invalidConfirmpasswrod, type: AlertType.error, navBar: false)
            return false
        }
        if  self.txt_ConfirmPassword.text!.trim() != self.txt_Password.text!.trim(){
            self.showAlert(message:  CS.Login.ConfrimPasswrod, type: AlertType.error, navBar: false)
            return false
        }
        if btn_privacy.isSelected == false{
            self.showAlert(message:  CS.Login.Terms, type: AlertType.error, navBar: false)
            return false
        }
        
        return true
    }
    
    // ----------------------------------------------------------                   
    //MARK:- Action method
    // ----------------------------------------------------------
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func apiCallingFuncation(){
        
        WebServicesManager.signUPWS(firstname: txt_firstname.text!.trim(), lastname: txt_lastname.text!.trim(),email: txt_email.text!.trim(), mobile: txt_mobile.text!.trim(), password: txt_Password.text!.trim(), address: "", onCompletion: { response in
            
            if response!["success"].intValue == 1 {
                let otpview = self.storyboard?.instantiateViewController(withIdentifier: CS.Identifiers.OTPvc) as! OTPvc
                otpview.formregister = true
                ConnflixUtilities.shared.mobile = self.txt_mobile.text!
                ConnflixUtilities.shared.UserID = response!["user_id"].stringValue
            
            self.navigationController?.pushViewController(otpview, animated: true)
                
            } else {
                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
            
        },onError:{ error in
            
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }
    @IBAction func OnTCPressed(_ sender: Any){
    
        btn_privacy.isSelected = !btn_privacy.isSelected
        
    }
    
    @IBAction func OnSubmitPressed(_ sender: Any)
    {
        //let otpview = self.storyboard?.instantiateViewController(withIdentifier: CS.Identifiers.OTPvc) as! OTPvc
        //otpview.formregister = true
        //self.navigationController?.pushViewController(otpview, animated: true)
        //return;
        if validateFields()
        {
            apiCallingFuncation()
            
          
        }
    }
    
    @IBAction func onProfilePicturePressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: Language.Common.ChooseOption, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: Language.Common.Camera , style: .default) { action in
            self.photoFromCamera()
        }
        alertController.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: Language.Common.PhotoLibrary, style: .default) { action in
            self.photoFromLibrary()
        }
        alertController.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: Language.Common.Cancel, style: .cancel) { action in }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    
    
    
    // ----------------------------------------------------------
    //MARK:- TextField Method
    // ----------------------------------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txt_firstname
        {
            txt_lastname.becomeFirstResponder()
        }else if textField == txt_lastname
        {
            txt_email.becomeFirstResponder()
        }
       else if textField == txt_email
        {
            txt_Password.becomeFirstResponder()
        }
       else if textField == txt_Password
        {
            txt_ConfirmPassword.becomeFirstResponder()
        }
        else if textField == txt_ConfirmPassword{
            //            self.OnSubmitPressed(self)
            txt_referralCode.becomeFirstResponder()
        }
        else{
            txt_referralCode.resignFirstResponder()
        }
        return false
    }
    
    
    
    // ----------------------------------------------------------
    //MARK:- IMAGE PROFILE
    // ----------------------------------------------------------
    
    private func photoFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func photoFromLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let original_image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img_profile.image = original_image
        self.img_profile.layer.cornerRadius = self.img_profile.frame.size.height/2
        self.img_profile.layer.borderWidth = 1.0
        
        dismiss(animated:true, completion: nil)
        
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
