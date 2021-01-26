//
//  SettingViewController.swift
//  Movie
//
//  Created by Gunjan Raval on 24/06/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SDWebImage
import IPImage
import SwiftyJSON

class MoreViewController: ParentClass,UITextFieldDelegate {
    
    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    
    fileprivate var btnPrivacyPolicy: SettingButton!
    fileprivate var btnTC: SettingButton!
    fileprivate var btnLogout: SettingButton!
//    var setting : SettingVC?

    var editProfile : EditProfileViewController?

    var imgProfile : UIImageView!
    var name : CustomLabel!
    var phn : CustomLabel!
    var scrlView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let data =  ParentClass.sharedInstance.getJSON(CS.Saved.userData)
        self.userDic  = User (fromJson: data)
        ConnflixUtilities.shared.firstname = userDic.firstName
        ConnflixUtilities.shared.lastname = userDic.lastName
        ConnflixUtilities.shared.profilePic = userDic.profilePic
        ConnflixUtilities.shared.mobile = userDic.mobile
        self.loadHeaderView()
       // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//            apiCallingFuncation()
    }

    func reloadProfileData() {
        print(ConnflixUtilities.shared.firstname)
        imgProfile.sd_setImage(with:URL (string:ConnflixUtilities.shared.profilePic!) , placeholderImage: UIImage(named: "gallery"), options: .progressiveLoad, completed: nil)
        name.text = "\(ConnflixUtilities.shared.firstname!) \(ConnflixUtilities.shared.lastname!)"
        phn.text = "\(ConnflixUtilities.shared.mobile!)"

    }
    
    func loadHeaderView() {
        
        yPosition = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)
        
        headerview = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(UIScreen.main.bounds.width), height: MORE_HEADER_HEIGHT));
        headerview.backgroundColor =  colorPrimary
        self.view.addSubview(headerview)
        
        imgProfile = UIImageView (frame: CGRect (x: X_PADDING, y: 15, width: controls_height, height: controls_height))
//        imgProfile.sd_setImage(with: URL (string:userDic.profilePic!), placeholderImage: UIImage(named: "gallery"), completed: nil)
        imgProfile.layer.cornerRadius = CGFloat(controls_height/2)
        imgProfile.layer.borderWidth = borderWidth
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.clipsToBounds = true
        headerview.addSubview(imgProfile)


        name = CustomLabel (frame: CGRect (x: X_PADDING + controls_height , y: 15, width: SCREEN_WIDTH - X_PADDING*2 - controls_height - 25, height: CUSTOM_TEXTFIELD_HEIGHT))
        name.textColor = .white
        name.text = "\(ConnflixUtilities.shared.firstname!) \(ConnflixUtilities.shared.lastname!)"
        headerview.addSubview(name)
        
         phn = CustomLabel (frame: CGRect (x: X_PADDING + controls_height , y: Int(name.bounds.height) + 10 , width: SCREEN_WIDTH - X_PADDING*2 - controls_height - 25, height: CUSTOM_TEXTFIELD_HEIGHT))
        phn.text = "\(ConnflixUtilities.shared.mobile!)"
        phn.textColor = .white
        headerview.addSubview(phn)
        
        let btnEdit = UIButton (frame: CGRect (x: SCREEN_WIDTH - TOP_HEADER_HEIGHT, y: 30, width: 40, height: 40))
        btnEdit.setImage(UIImage (named: "edit"), for: .normal)
        btnEdit.addTarget(self, action: #selector(onEditPressed), for: .touchUpInside)
        headerview.addSubview(btnEdit)
        
        yPosition += Int(headerview.bounds.height) +  Y_PADDING
        
        print(userDic.profilePic)
        if userDic.profilePic == ""{
            DispatchQueue.main.async {
                let ipimage = IPImage(text: self.name.text!, radius: Double(self.imgProfile.bounds.height/2), font: UIFont (name: APP_FONT_NAME_BOLD, size: 30), textColor: nil, randomBackgroundColor: true)
                self.imgProfile.image = ipimage.generateImage()
            }

        }else{
            imgProfile.sd_setImage(with:URL (string:userDic.profilePic!) , placeholderImage: UIImage(named: "gallery"), options: .progressiveLoad, completed: nil)

        }
        self.initScroll()

    }
    
    func initScroll() {
        
         scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .white
        self.view.addSubview(scrlView)
        
        var yInternalPosition = Y_PADDING
        
        btnPrivacyPolicy = SettingButton (frame: CGRect (x: X_PADDING, y: yInternalPosition, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        btnPrivacyPolicy.setTitle("Privacy Policy", for: .normal)
        btnPrivacyPolicy.setImage(UIImage (named: "privacy"), for: .normal)
        btnPrivacyPolicy.tag = 1
        btnPrivacyPolicy.addTarget(self, action: #selector(onBtnPressed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnPrivacyPolicy)
        
        yInternalPosition += Int(btnPrivacyPolicy.bounds.height) + Y_PADDING
        
        btnTC = SettingButton (frame: CGRect (x: X_PADDING, y: yInternalPosition, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        btnTC.setTitle("Terms & Conditions", for: .normal)
        btnTC.tag = 2
        btnTC.addTarget(self, action: #selector(onBtnPressed(sender:)), for: .touchUpInside)
        btnTC.setImage(UIImage (named: "term"), for: .normal)
        scrlView.addSubview(btnTC)

        yInternalPosition += Int(btnTC.bounds.height) + Y_PADDING
        
        btnLogout = SettingButton (frame: CGRect (x: X_PADDING, y: yInternalPosition, width: SCREEN_WIDTH - X_PADDING*2, height: NEXT_BUTTON_HEIGHT))
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.setImage(UIImage (named: "logout"), for: .normal)
        btnLogout.tag = 3
        btnLogout.addTarget(self, action: #selector(onBtnPressed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnLogout)
        
        yInternalPosition += Int(btnLogout.bounds.height) + Y_PADDING

        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yInternalPosition )

    }

    @objc func onEditPressed(){
        editProfile = EditProfileViewController()
        editProfile?.delegate = self
        self.navigationController?.pushViewController(editProfile!, animated: true)
    }

    @objc func OnlogoutPressed() {
        DispatchQueue.main.async(execute: {
            let alert =  Utils.getAlertController(title: "Alert", message: CS.Common.msgLogout, style: .alert)
            alert.addAction((UIAlertAction(title: CS.Common.msgyes, style: .cancel, handler: {(action) -> Void in
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CS.Identifiers.LoginVC) as? LoginVC {
                    ParentClass.sharedInstance.saveJSON(json: JSON(), key: CS.Saved.userData)
                    if let navigator = self.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            })))
            alert.addAction((UIAlertAction(title: CS.Common.msgNo, style: .default, handler: {(action) -> Void in
            })))
            self.present(alert, animated: true, completion: nil)
        })
    }
   @objc func onBtnPressed(sender:UIButton){

    if sender.tag == 1 || sender.tag == 2{
        let privacy = PrivacyPolicyViewController()
        privacy.tag = sender.tag
        self.navigationController?.pushViewController(privacy, animated: true)
    }else{
        OnlogoutPressed()
    }
  }
    
}
