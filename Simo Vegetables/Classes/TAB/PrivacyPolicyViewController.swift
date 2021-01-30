//
//  PrivacyPolicyViewController.swift
//  Movie
//
//  Created by Gunjan Raval on 30/07/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: ParentClass {
    
    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    var textContent : String!
    var txtView : UITextView!
    var strTitle : String!
    var tag : Int!
    var url : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         if tag == 1{
            url = "privacy_policy"
        }else if tag == 2{
            url = "terms_condition"
        }
        
        apiCallingFuncation()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
  
    func loadHeaderView() {
        
        yPosition = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)
        
        headerview = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)
        
        self.buttonBack = CustomButton(frame: CGRect(x: X_PADDING, y: 0, width: NAV_HEADER_HEIGHT  , height: NAV_HEADER_HEIGHT))
        self.buttonBack.setImage(UIImage (named: "back"), for: .normal)
        self.buttonBack.contentHorizontalAlignment = .center
        self.buttonBack.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        let  buttonTitle = UIButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH - NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle(strTitle, for: .normal)
        buttonTitle.contentHorizontalAlignment = .left
        headerview.addSubview(buttonTitle)
        
        yPosition += Int(headerview.bounds.height) +  Y_PADDING
        
        txtView = UITextView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        txtView.attributedText = textContent.htmlToAttributedString
        txtView.backgroundColor = .clear
//        txtView.textColor = .white
        txtView.isEditable = false
//        txtView.isUserInteractionEnabled = false
        self.view.addSubview(txtView)
        
        
    }
    @objc func noDataAlert(strMsg:String) {
        DispatchQueue.main.async(execute: {
            let alert =  Utils.getAlertController(title: "Alert", message: strMsg, style: .alert)
            alert.addAction((UIAlertAction(title: "Okay", style: .cancel, handler: {(action) -> Void in
                self.onBackPressed()
            })))
            self.present(alert, animated: true, completion: nil)
        })
    }

    func apiCallingFuncation(){
        
        WebServicesManager.commonDocWS(key:url, view: self.view, onCompletion: { response in
            
                self.textContent = response!["description"].string
                self.strTitle  = response!["title"].string
                self.loadHeaderView()
//            } else {
//                self.noDataAlert(strMsg: response!["message"].stringValue)
//            }
            
        },onError:{ error in
            
            if error != nil {
                self.noDataAlert(strMsg: CS.Common.wrongMsg)

//                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
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
