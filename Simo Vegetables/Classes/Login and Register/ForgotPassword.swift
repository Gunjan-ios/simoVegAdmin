//
//  ForgotPassword.swift
//  InitialWork
//
//  Created by Gunjan on 08/03/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import TextFieldEffects
import JAPinView
import CountryPickerView

class ForgotPassword: ParentClass,UITextFieldDelegate,CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        cuntryCode = country.phoneCode
//        ConnflixUtilities.shared.countryCode = cuntryCode
    }

    @IBOutlet weak var txt_email: MadokaTextField!
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var blurview: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var txt_CountryCode: CountryTextfiled!
    @IBOutlet weak var imgEmail: UIImageView!

     var cuntryCode : String!
    weak public var dataSource: CountryPickerViewDataSource?
    weak public var delegate: CountryPickerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgEmail.setImageColor(color: colorPrimary)

        settings()
        setupCountryPicker()
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
        txt_email.delegate = self
        MadokaTextField.appearance().tintColor = .white
        self.btn_submit.layer.cornerRadius = self.btn_submit.frame.size.height/2
        self.blur.clipsToBounds = true;
        self.blur.layer.cornerRadius = self.blur.frame.size.height/2
    }
    
    func apiCallingFuncation(){
        let otpview = self.storyboard?.instantiateViewController(withIdentifier: CS.Identifiers.OTPvc) as! OTPvc
        ConnflixUtilities.shared.mobile = self.txt_email.text!
        otpview.formregister = false
        self.navigationController?.pushViewController(otpview, animated: true)
        return;
        WebServicesManager.resendORForgotOtpWS(mobile: txt_email.text!, type: "Forgot", view: self.view,  onCompletion: { response in
            
            if response!["success"].intValue == 1 {
                
                let otpview = self.storyboard?.instantiateViewController(withIdentifier: CS.Identifiers.OTPvc) as! OTPvc
                ConnflixUtilities.shared.mobile = self.txt_email.text!
                otpview.formregister = false
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
    
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Loclized Setting -
    //––––––––––––––––––––––––––––––––––––––––
 
    private func validateFields() -> Bool {
        
//        let validation = Validation()
        
        if !self.txt_email.notEmpty() ||  self.txt_email.text!.count < 10{
            self.showAlert(message: CS.Login.invalidMobile, type: AlertType.error, navBar: false)
            return false
        }

        
        return true
    }
    // ----------------------------------------------------------
    //MARK:- Action method
    // ----------------------------------------------------------
    
    @IBAction func OnSubmitPressed(_ sender: Any)
    {
        if validateFields(){
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
       textField.resignFirstResponder()
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
