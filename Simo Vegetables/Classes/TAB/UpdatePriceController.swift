//
//  HomeViewController.swift
//  Simo Vegetables
//
//  Created by Apple on 10/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit

class UpdatePriceController: ParentClass  ,UITableViewDelegate,UITableViewDataSource{
    
    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    fileprivate var buttonDate : CustomComboBoxView!
    fileprivate var mainView  : UIView!
    fileprivate var topView : UIView!
    fileprivate var buttonPlaceOrder: CustomButton!

    fileprivate var swtchEnble : UISwitch!

    fileprivate var tblList: UITableView!
//    fileprivate var tblconfirmOrderList: UITableView!

    var orderDetails : [OrderPlaceProduct]! = [OrderPlaceProduct]()
    var placeorderDetails : [OrderPlaceProduct]! = [OrderPlaceProduct]()

    var orderedData : [OrderListItem]! = [OrderListItem]()

    var tabHeight : Int = 0
    var bottmheightAdjust : Int = 0

    var strOrder : String!
    var paramQuntity = NSMutableDictionary()

//    var mainConfimVIew : UIView!
    fileprivate var buttonsubmitOrder: CustomButton!
    fileprivate var buttonEditOrder: CustomButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        tabHeight = Int((self.tabBarController?.tabBar.bounds.height)!)
        self.view.backgroundColor = .white
        loadHeaderView()
        apiCallingFuncation(strDate: "")
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//    }
    
    func loadHeaderView() {

        yPosition = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)

        headerview = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)

        let buttonTitle = CustomButton(frame: CGRect(x: 0 , y: 0, width: SCREEN_WIDTH , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle("Update daily price of items", for: .normal)
        buttonTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonTitle.contentHorizontalAlignment = .center
        headerview.addSubview(buttonTitle)

        yPosition += Int(headerview.bounds.height) + Y_PADDING

        if IS_IPHONE_X_XR_XMAX_12{
            bottmheightAdjust = 65
        }else{
            bottmheightAdjust = 50
        }
        let lbl = CustomLabel (frame: CGRect (x: 70, y: SCREEN_HEIGHT  - bottmheightAdjust - tabHeight - 4, width: SCREEN_WIDTH - X_PADDING*2 - 70 , height: 40))
        lbl.text = "Price Enble?"
        lbl.font = UIFont (name: APP_FONT_NAME_BOLD, size: NAV_HEADER_FONT_SIZE)
        lbl.textColor = .black
        self.view.addSubview(lbl)

        swtchEnble = UISwitch(frame: CGRect(x:  X_PADDING , y: SCREEN_HEIGHT  - bottmheightAdjust - tabHeight , width: 70, height: 40))
        swtchEnble.addTarget(self, action: #selector(priceEnableAPICallingFuncation(sender:)), for: .valueChanged)
        self.view.addSubview(swtchEnble)

        bottmheightAdjust += 40

        buttonPlaceOrder = CustomButton(frame: CGRect(x:  SCREEN_WIDTH - 160 , y: SCREEN_HEIGHT  - bottmheightAdjust - tabHeight , width: 150 , height: 40))
        buttonPlaceOrder.setTitle("Submit", for: .normal)
        buttonPlaceOrder.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonPlaceOrder.addTarget(self, action: #selector(handelOrderPlace), for: .touchUpInside)
        buttonPlaceOrder.contentHorizontalAlignment = .center
        self.view.addSubview(buttonPlaceOrder)




    }
    @objc func onBackPressed(){
//        mainConfimVIew.isHidden = true
//        mainView.isHidden = false
    }
    func getTableData(){
        for i in 0..<tblList.numberOfRows(inSection: 0) {
            let dic = orderDetails[i]
            let cell = tblList.cellForRow(at: IndexPath(row: i, section: 0)) as? PlaceOrderTableViewCell
            if cell == nil{
                continue;
            }
            let set = "\(cell!.txtbuyquanty.text ?? "")|\(cell!.txtsellquanty.text ?? "")"
            if cell?.txtbuyquanty.text != ""  || cell?.txtsellquanty.text != ""{
                paramQuntity.setValue(set, forKey: dic.productId)
            }
        }
        strOrder = Utils.stringFromJson(obj: paramQuntity as! [String : Any])
         print(strOrder as String)
    }
    @objc func handelOrderPlace(){
        getTableData()
        if paramQuntity.count > 0{
            placeOrderApiCallingFuncation()
        }else{
            self.showAlert(message: "Please make order First.", type: AlertType.error, navBar: false)

        }

    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - API Function
    //––––––––––––––––––––––––––––––––––––––––

    func apiCallingFuncation( strDate : String){

        WebServicesManager .productList(ordered_products: 1, search: "", view: self.view, date: strDate, onCompletion: { [self] response in

            if response!["success"].intValue == 1 {
                let res =  response!["products"].arrayValue
                for temp in res{
                    let value = OrderPlaceProduct.init(fromJson: temp)
                    self.orderDetails.append(value)
                }
                if self.tblList != nil{
                    self.tblList.reloadData()
                }else{
                    self.initTableview()
                }
                self.buttonPlaceOrder.isHidden = false
                let checked =  response!["checked"].boolValue
                swtchEnble.isOn = checked
            } else {
                if self.tblList != nil{
                    self.tblList.isHidden = true
                }
                self.lblSubTitle.isHidden = false
                self.buttonPlaceOrder.isHidden = true
            }
        },onError:{ error in
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }

    @objc func placeOrderApiCallingFuncation(){

        WebServicesManager .updatePrice(ordered_products: strOrder, view: self.view, onCompletion: { response in
            if response!["success"].intValue == 1 {
                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
        },onError:{ error in
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }

 @objc  func priceEnableAPICallingFuncation(sender: UISwitch){

    let status : Int!
    if sender.isOn {
        status  = 1
    }else{
        status = 0
    }
    WebServicesManager .priceEnableAPI(status: status, view: self.view, onCompletion: { response in
            if response!["success"].intValue == 1 {
                let msg  = response!["message"].stringValue
                self.showAlert(message: msg, type: AlertType.success, navBar: false)
            }
        },onError:{ error in
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }
//    Int((self.tabBarController?.tabBar.frame.height)!)
    func initTableview()  {
        // layer list
        self.tblList = UITableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition - tabHeight  - ParentClass.sharedInstance.iPhone_X_Bottom_Padding - bottmheightAdjust ), style: .plain)
        self.tblList.delegate = self
        self.tblList.dataSource = self
        self.tblList.tag = 8888
        self.tblList.register(PlaceOrderTableViewCell.self, forCellReuseIdentifier: "PlaceOrderTableViewCell")
        self.tblList.separatorStyle = .singleLine
        self.tblList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = .white
        self.tblList.estimatedRowHeight = UITableView.automaticDimension
        self.tblList.rowHeight = TABLEVIEW_CELL_HEIGHT
        self.view.addSubview(self.tblList)
        self.tblList.tableFooterView = UIView()
        self.tblList.endEditing(true)
    }

//    func initConfirmOrderTableview()  {
//        // layer list
//        self.tblconfirmOrderList = UITableView (frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: Int(mainView.bounds.height) - bottmheightAdjust - 10), style: .plain)
//        self.tblconfirmOrderList.delegate = self
//        self.tblconfirmOrderList.dataSource = self
//        self.tblconfirmOrderList.tag = 7777
//        self.tblconfirmOrderList.register(ConfirmOrderTableViewCell.self, forCellReuseIdentifier: "ConfirmOrderTableViewCell")
//        self.tblconfirmOrderList.separatorStyle = .singleLine
//        self.tblconfirmOrderList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
//        self.tblconfirmOrderList.showsVerticalScrollIndicator = false
//        self.tblconfirmOrderList.backgroundColor = .white
//        self.tblconfirmOrderList.estimatedRowHeight = UITableView.automaticDimension
//        self.tblconfirmOrderList.rowHeight = CONFIRM_CELL_HEIGHT
//        mainConfimVIew.addSubview(self.tblconfirmOrderList)
//        self.tblconfirmOrderList.tableFooterView = UIView()
//
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblList{
            return orderDetails.count
        }else{
            return placeorderDetails.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tblList{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceOrderTableViewCell.self)) as! PlaceOrderTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.contentView.isUserInteractionEnabled = false
//            cell.delegate = self

            cell.txtbuyquanty.delegate = self
            cell.txtbuyquanty.tag = indexPath.row

            cell.txtsellquanty.delegate = self
            cell.txtsellquanty.tag = indexPath.row

//            cell.txtquanty.addTarget(self, action: #selector(textFieldDidEndEditing(textField:)), for: .valueChanged)

            let dic = orderDetails[indexPath.row]
            cell.lblFieldName.text = dic.productName

            cell.txtbuyquanty.placeholder = "Purchase Price"
            cell.txtPurchaseQuanty.placeholder = "Purchase Price"
            cell.txtsellquanty.placeholder = "Selling Price"

            cell.txtbuyquanty.text = dic.purchasePrice
            cell.txtsellquanty.text = dic.salePrice

            cell.imgItem.sd_setImage(with: URL (string: dic.image!), placeholderImage: nil, options: .progressiveLoad)
//            if orderedData.count > 0{
//                for orderdic in orderedData{
//                    if orderdic.productId == dic.productId{
//                        cell.txtquanty.text = orderdic.quantity
//                        textFieldDidEndEditing(cell.txtquanty)
//                    }
//                }
//            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfirmOrderTableViewCell.self)) as! ConfirmOrderTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear

            let dic = placeorderDetails[indexPath.row]
//            cell.btnqunty.setTitle("Qty : \(dic.myOrder ?? "0")", for: .normal)
            cell.btnqunty.setTitle("Qty : \(dic.myOrder ?? "0") \(dic.unit ?? "")", for: .normal)

            cell.lblFieldName.text = dic.productName

            cell.imgItem.sd_setImage(with: URL (string: dic.image!), placeholderImage: nil, options: .progressiveLoad)

            return cell
        }
    }
}


extension UpdatePriceController : UITextFieldDelegate{

     func textFieldDidEndEditing(_ textField: UITextField) {

//        let keyExiest = paramQuntity[textField.tag] != nil
//        let dic = orderDetails[textField.tag]
//
//        if !textField.text!.isEmpty{
//            if keyExiest{
//                paramQuntity[textField.tag] = textField.text
//            }else{
//                dic.myOrder = textField.text
//                placeorderDetails.append(dic)
//                paramQuntity.setValue(textField.text!, forKey: dic.productId)
//            }
//            strOrder = Utils.stringFromJson(obj: paramQuntity as! [String : Any])
//            print(strOrder as Any)
//        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
