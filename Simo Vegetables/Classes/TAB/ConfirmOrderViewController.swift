//
//  ConfirmOrderViewController.swift
//  Simo Vegetables
//
//  Created by Apple on 17/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: ParentClass {

    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    fileprivate var buttonDate : CustomComboBoxView!
    fileprivate var mainView  : UIView!
    fileprivate var topView : UIView!
    fileprivate var buttonPlaceOrder: CustomButton!
    fileprivate var buttonEditOrder: CustomButton!

    fileprivate var tblList: UITableView!
    var orderDetails : [OrderPlaceProduct]! = [OrderPlaceProduct]()
    var tabHeight : Int = 0
    var bottmheightAdjust : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabHeight = Int((ParentClass.sharedInstance.tab.tabBar.bounds.height))
        self.view.backgroundColor = .white
        loadHeaderView()
        print(ParentClass.sharedInstance.tab.selectedIndex)
        
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
        
        let buttonTitle = CustomButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle("My Item Listing", for: .normal)
        buttonTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonTitle.contentHorizontalAlignment = .left
        headerview.addSubview(buttonTitle)

//        let buttonsubTitle = UIButton(frame: CGRect(x: 0 , y: 24, width: SCREEN_WIDTH , height: 17))
//        buttonsubTitle.setTitle("Set quantity & place order", for: .normal)
//        buttonsubTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: SUB_HEADER_LABEL_FONT_SIZE)
//        buttonsubTitle.contentHorizontalAlignment = .center
//        headerview.addSubview(buttonsubTitle)

        yPosition += Int(headerview.bounds.height) + Y_PADDING

        if IS_IPHONE_X_XR_XMAX_12{
            bottmheightAdjust = 65
        }else{
            bottmheightAdjust = 50
        }

        buttonEditOrder = CustomButton(frame: CGRect(x:  Y_PADDING , y: SCREEN_HEIGHT - tabHeight - bottmheightAdjust - ParentClass.sharedInstance.iPhone_X_Bottom_Padding, width: SCREEN_WIDTH/2 - X_PADDING , height: 40))
        buttonEditOrder.setTitle("Edit Order", for: .normal)
        buttonEditOrder.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonEditOrder.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        buttonEditOrder.contentHorizontalAlignment = .center
        self.view.addSubview(buttonEditOrder)

        buttonPlaceOrder = CustomButton(frame: CGRect(x: SCREEN_WIDTH/2  + Y_PADDING, y: SCREEN_HEIGHT - tabHeight - bottmheightAdjust - ParentClass.sharedInstance.iPhone_X_Bottom_Padding, width: SCREEN_WIDTH/2  - X_PADDING , height: 40))
        buttonPlaceOrder.setTitle("Confirm & Submit", for: .normal)
        buttonPlaceOrder.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonPlaceOrder.addTarget(self, action: #selector(onSubmitPressed), for: .touchUpInside)
        buttonPlaceOrder.contentHorizontalAlignment = .center
        self.view.addSubview(buttonPlaceOrder)


    }
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func onSubmitPressed(){
        self.navigationController?.popViewController(animated: true)
        ParentClass.sharedInstance.tab.selectedIndex = 1
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
