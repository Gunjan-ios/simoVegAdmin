//
//  EditProfileViewController.swift
//  Movie
//
//  Created by Gunjan Raval on 26/06/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SDWebImage
import IPImage
class EditProfileViewController: ParentClass,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    
    fileprivate var txtFirst : CustomInputTextField!
    fileprivate var txtLast : CustomInputTextField!
    fileprivate var txtEmail : CustomInputTextField!
    fileprivate var txtMobile : CustomInputTextField!
    fileprivate var btnSubmit : ThemeColorButton!
    fileprivate var  imgProfile : UIImageView!
    var param : [String:Any] =  [String:Any]()
    var delegate : MoreViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderView()
        // Do any additional setup after loading the view.
    }
    
    func loadHeaderView() {
        
        let data =  ParentClass.sharedInstance.getJSON(CS.Saved.userData)
        self.userDic  = User (fromJson: data)
        
        yPosition = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)
        
        headerview = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)
        
        self.buttonBack = CustomButton(frame: CGRect(x: X_PADDING, y: 0, width: NAV_HEADER_HEIGHT  , height: NAV_HEADER_HEIGHT))
        self.buttonBack.setImage(UIImage (named: "back"), for: .normal)
        self.buttonBack.contentHorizontalAlignment = .center
        self.buttonBack.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        let buttonTitle = CustomButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH - NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle("My Profile", for: .normal)
        buttonTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonTitle.contentHorizontalAlignment = .left
        headerview.addSubview(buttonTitle)

        yPosition += Int(headerview.bounds.height)
        
       self.initScroll()
    }
    
    func initScroll(){
        
        let scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .white
        self.view.addSubview(scrlView)
        
        var yInternalSpace = YTEXTFILED_PADDING
        
        imgProfile = UIImageView (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: controls_height, height: controls_height))
        imgProfile.sd_setImage(with:URL (string:userDic.profilePic!) , placeholderImage: UIImage(named: "gallery"), options: .progressiveLoad, completed: nil)
        imgProfile.layer.cornerRadius = CGFloat(controls_height/2)
        imgProfile.layer.borderWidth = borderWidth
        imgProfile.layer.borderColor = colorPrimary.cgColor
        imgProfile.clipsToBounds = true
        scrlView.addSubview(imgProfile)
        
        
        let buttonEdit = UIButton(frame: CGRect(x:Int(imgProfile.frame.width) , y: yInternalSpace, width: 25  , height: 25))
        buttonEdit.setImage(UIImage (named: "edit"), for: .normal)
        buttonEdit.layer.cornerRadius = buttonEdit.bounds.width/2
        buttonEdit.imageEdgeInsets = UIEdgeInsets (top: 5, left: 5, bottom: 5, right: 5)
        buttonEdit.backgroundColor = colorPrimary
        buttonEdit.contentHorizontalAlignment = .center
        buttonEdit.addTarget(self, action: #selector(onProfilePicturePressed(_:)), for: .touchUpInside)
        scrlView.addSubview(buttonEdit)
        
        
        let btnChangePassword = UIButton (frame: CGRect(x:Int(imgProfile.bounds.width) + X_PADDING * 2, y: yInternalSpace + 25, width: 130 , height: 21))
        btnChangePassword.setTitle("Change Password", for: .normal)
        btnChangePassword.contentHorizontalAlignment = .center
        btnChangePassword.backgroundColor = colorCommonBackground
        btnChangePassword.layer.cornerRadius = radius
        btnChangePassword.titleLabel?.font = UIFont .boldSystemFont(ofSize: 12)
        btnChangePassword.addTarget(self, action: #selector(onChangePasswordPressed), for: .touchUpInside)
        scrlView.addSubview(btnChangePassword)
        
        yInternalSpace +=  Int(imgProfile.bounds.height) + YTEXTFILED_PADDING*2
        
//        txtFirst = MDCOutlinedTextField (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
//
//        txtFirst.InitDesign(pImageName: "profile", PInfoText: "First name", pPlaceHolder: "John")
//        txtFirst.sizeToFit()
//        //        txtFirst.initDesign(pImageName: "profile", pTag: 1, pPlaceHolder: "Please enter first name")
//        scrlView.addSubview(txtFirst)

        txtFirst = CustomInputTextField (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        txtFirst.initDesign(pText: self.userDic.firstName, pImageName: "profile", pTag: 1, pPlaceHolder: "Please enter first name")
        scrlView.addSubview(txtFirst)
        
        yInternalSpace +=  Int(txtFirst.bounds.height) + YTEXTFILED_PADDING

        txtLast = CustomInputTextField (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        txtLast.initDesign(pText: self.userDic.lastName, pImageName: "profile", pTag: 2, pPlaceHolder: "Please enter last name")
        scrlView.addSubview(txtLast)

        yInternalSpace +=  Int(txtLast.bounds.height) + YTEXTFILED_PADDING

        txtEmail = CustomInputTextField (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        txtEmail.initDesign(pText: self.userDic.email, pImageName: "message", pTag: 3, pPlaceHolder: "Please enter email address")
        scrlView.addSubview(txtEmail)
        
        yInternalSpace +=  Int(txtEmail.bounds.height) + YTEXTFILED_PADDING

        txtMobile = CustomInputTextField (frame: CGRect (x: X_PADDING, y: yInternalSpace, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        txtMobile.initDesign(pText: self.userDic.mobile, pImageName: "phone", pTag: 4, pPlaceHolder: "Please enter mobile")
        scrlView.addSubview(txtMobile)
        
        yInternalSpace +=  Int(txtMobile.bounds.height) + YTEXTFILED_PADDING
        
        btnSubmit = ThemeColorButton (frame: CGRect(x:0 , y: yInternalSpace, width: Int(SCREEN_WIDTH/3), height: CUSTOM_BUTTON_HEIGHT))
        btnSubmit.center = CGPoint (x: self.view.center.x , y: btnSubmit.center.y)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.layer.cornerRadius = radius
        btnSubmit.backgroundColor = colorPrimary
        btnSubmit.addTarget(self, action: #selector(apiCallingFuncation), for: .touchUpInside)
        scrlView.addSubview(btnSubmit)
        
        yInternalSpace +=  Int(btnSubmit.bounds.height) + YTEXTFILED_PADDING

        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yInternalSpace)
        
        if userDic.profilePic == ""{

            DispatchQueue.main.async {
            let ipimage = IPImage(text: self.userDic.firstName!, radius: Double(self.imgProfile.bounds.height/2), font: UIFont (name: APP_FONT_NAME_BOLD, size: 30), textColor: nil, randomBackgroundColor: true)
            self.imgProfile.image = ipimage.generateImage()
            }
//            let ipimage = IPImage(text: "New Raval", radius: 35, font: UIFont (name: APP_FONT_NAME_BOLD, size: 30), textColor: nil, randomBackgroundColor: true)
//            imgProfile.image = ipimage.generateImage()
//            imgProfile.layoutIfNeeded()
//            print(imgProfile.image)
        }
    }
    
    @objc func onChangePasswordPressed(){
  
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CS.Identifiers.ResetPasswordVC) as? ResetPasswordVC {
            viewController.fromWhere = "Change"
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func apiCallingFuncation(){
    
        param.updateValue(txtFirst.txtField.text!, forKey: CS.Params.first_name)
        param.updateValue(txtLast.txtField.text!, forKey: CS.Params.last_name)
        param.updateValue(txtEmail.txtField.text!, forKey: CS.Params.email)
        param.updateValue(txtMobile.txtField.text!, forKey: CS.Params.mobile)
        param.updateValue(userDic.userId!, forKey: CS.Params.user_id)
        param.updateValue(true, forKey: CS.Params.from_app)

        print(param)
        
     WebServicesManager.profileUpdateWS(formData:param , onCompletion: { response in
            
            if response!["success"].intValue == 1 {
                
                self.apiCallingFuncationProfile()
                self.showAlert(message: response!["message"].stringValue, type: AlertType.success, navBar: false)

            } else {
                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
            
        },onError:{ error in
            
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
            
        })
    }
    func apiCallingFuncationProfile(){

        WebServicesManager.profileWS(user_id: ConnflixUtilities.shared.UserID!, onCompletion: { response in

            if response!["success"].intValue == 1 {
                self.userDic  = User.init(fromJson: response!["user"])
                ConnflixUtilities.shared.mobile =  self.userDic .mobile
                ConnflixUtilities.shared.UserID =  self.userDic .userId
                ConnflixUtilities.shared.email =  self.userDic .email
                ConnflixUtilities.shared.profilePic =  self.userDic .profilePic
                ConnflixUtilities.shared.firstname =  self.userDic .firstName
                ConnflixUtilities.shared.lastname =  self.userDic .lastName
                ParentClass.sharedInstance.saveJSON(json:response!["user"] , key: CS.Saved.userData)
                self.delegate?.reloadProfileData()
            } else {
                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }

        }) { error in

            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        }
    }
    @objc func onProfilePicturePressed(_ sender: Any) {
        
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
        imgProfile.image = original_image
        let imgData = original_image.jpegData(compressionQuality: 0.3)
        let ans = AGImageInfo (fileName: "\(userDic.userId!).jpg", type: Utils.mimeType(for: imgData!), data:imgData!)
        param.updateValue(ans, forKey: CS.Params.profile_pic)
//        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
//        self.imgProfile.layer.borderWidth = 1.0
//
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
