//
//  OTPvc.swift
//  InitialWork
//
//  Created by Gunjan on 04/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import TextFieldEffects
import JAPinView
import OTPFieldView

class OTPvc: ParentClass,UITextFieldDelegate  {
    
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var lblVerify: UILabel!
    @IBOutlet weak var blurview: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!

    @IBOutlet weak var imgEmail: UIImageView!

    var formregister : Bool = false
    var strPin : String = ""

    var count = 59
    var timer:Timer?
    var  Pre_timestamp : TimeInterval?


    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
        imgEmail.setImageColor(color: colorPrimary)
        setupTimer()
        lblMobile.text = ConnflixUtilities.shared.mobile!
        setupOtpView()
        if formregister{
            print("true")
        }
        
        // Do any additional setup after loading the view.
    }
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.white
        self.otpTextFieldView.filledBorderColor = UIColor.green
        self.otpTextFieldView.defaultBackgroundColor = colorCommonBackground
        self.otpTextFieldView.filledBackgroundColor = .lightGray
        self.otpTextFieldView.cursorColor = UIColor.white
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    func setupTimer() {
        DispatchQueue.main.async(execute: {
            self.Pre_timestamp = NSDate().timeIntervalSinceReferenceDate
            print(self.Pre_timestamp as Any)
            self.timer = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(self.onTimerFires), userInfo: nil, repeats: true)})
    }
    @objc func onTimerFires() {

        let timestamp = NSDate().timeIntervalSinceReferenceDate
        let current = timestamp - Pre_timestamp!
        print("diffe:-  \(current)")
        let final_count = count - Int(current)
        btnTimer.setTitle(seconds2Timestamp(intSeconds: final_count), for: .normal)
        if final_count <= 0 {
            btnTimer.setTitle("Resend Code", for: .normal)
            timer?.invalidate()
            timer = nil
        }
    }
    
    func seconds2Timestamp(intSeconds:Int)->String {
        let mins:Int = (intSeconds/60)%60
        //        let hours:Int = intSeconds/3600
        let secs:Int = intSeconds%60
        
        let strTimestamp:String =  ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)
        return strTimestamp
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Settings -
    //––––––––––––––––––––––––––––––––––––––––
    private func settings(){
        
        MadokaTextField.appearance().tintColor = .white
        self.btn_submit.layer.cornerRadius = self.btn_submit.frame.size.height/2
        self.blur.clipsToBounds = true;
        self.blur.layer.cornerRadius = self.blur.frame.size.height/2
    }
    
    @IBAction func onResendCodePressed(_ sender: UIButton) {
        if sender.currentTitle == "Resend Code"{
//            if validateFields(strType: "Resend"){
                apiCallingFuncation()
//            }
        }
        
    }
    
    func apiCallingFuncation(){
        
        WebServicesManager.resendORForgotOtpWS(mobile: ConnflixUtilities.shared.mobile!, type: "Resend", view: self.view,  onCompletion: { response in
            self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
        },onError:{ error in
            
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
            
        })
    }

    
    
    func apiCallingFuncationForVerify(){
        
        WebServicesManager.verifyOtpWS (otp: strPin, mobile: ConnflixUtilities.shared.mobile!,view: self.view ,onCompletion: { response in
            
            if response!["success"].intValue == 1 {
                if self.formregister{
                    
//                    let userData = User.init(fromJson: response!["user"])
//                    ConnflixUtilities.shared.mobile = userData.mobile
//                    ConnflixUtilities.shared.UserID = userData.userId
//                    ConnflixUtilities.shared.email = userData.email
//                    ConnflixUtilities.shared.countryCode = userData.countryCode
//                    ConnflixUtilities.shared.profilePic = userData.profilePic
//                    ConnflixUtilities.shared.firstname = userData.firstName
//                    ConnflixUtilities.shared.lastname = userData.lastName
//                    ConnflixUtilities.shared.referralCode = userData.referralCode
//                    ConnflixUtilities.shared.selectVideoType = CS.strings.allType

                    ParentClass.sharedInstance.saveJSON(json:response!["user"] , key: CS.Saved.userData)

                   self.navigationController?.pushViewController(ParentClass.sharedInstance.customBouncesStyle(), animated: true)
                }else{
                    let reset = self.storyboard?.instantiateViewController(withIdentifier: CS.Identifiers.ResetPasswordVC) as! ResetPasswordVC
                    reset.fromWhere = "login"
                    self.navigationController?.pushViewController(reset, animated: true)
                }
                
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
    //MARK: - validateFields
    //––––––––––––––––––––––––––––––––––––––––


    private func validateFields(strType: String) -> Bool {
        
//        let validation = Validation()

        if strPin.isEmpty && strType == "Submit"{
            self.showAlert(message:  CS.Login.otpMsg, type: AlertType.error, navBar: false)
            return false
        }
        
        return true
    }
    // ----------------------------------------------------------
    //MARK:- Action method
    // ----------------------------------------------------------
    
    @IBAction func OnSubmitPressed(_ sender: Any)
    {
        if validateFields(strType:"Submit") {
            apiCallingFuncationForVerify()
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
extension OTPvc: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return true
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.strPin = otpString
    }
}
