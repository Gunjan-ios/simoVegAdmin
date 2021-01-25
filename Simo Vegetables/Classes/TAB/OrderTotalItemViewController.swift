//
//  OrderTotalItemViewController.swift
//  Simo Vegetables
//
//  Created by Apple on 25/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit

class OrderTotalItemViewController:  ParentClass  ,UITableViewDelegate,UITableViewDataSource {
    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    fileprivate var buttonDate : CustomComboBoxView!
    fileprivate var mainView  : UIView!
    fileprivate var topView : UIView!
    fileprivate var buttonPlaceOrder: CustomButton!
    fileprivate var buttonEditOrder: CustomButton!

    var tabHeight : Int = 0
    var bottmheightAdjust : Int = 0

    fileprivate var tblconfirmOrderList: UITableView!
    var placeorderDetails : [OrderPlaceProduct]! = [OrderPlaceProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
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

        let buttonTitle = CustomButton(frame: CGRect(x: 0 , y: 0, width: SCREEN_WIDTH , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle("Your Order", for: .normal)
        buttonTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonTitle.contentHorizontalAlignment = .center
        headerview.addSubview(buttonTitle)

        yPosition += Int(headerview.bounds.height) + Y_PADDING

        buttonDateView()
    }
    func buttonDateView(){

        buttonDate = CustomComboBoxView(frame: CGRect (x: SCREEN_WIDTH - 140, y: yPosition, width: 130, height: NAV_HEADER_HEIGHT))
        buttonDate.delegateOrder = self
        buttonDate.initDesign(pName:"", pTag: 1, pOptions: [], pPlaceHolder: "Select Date")
        buttonDate.setDatePicker()
        self.view.addSubview(buttonDate)

        yPosition += Int(buttonDate.bounds.height)

        apiCallingFuncation(strDate: "")

        //        initscrollview()
    }
    func getSelectDate(date : String){
        apiCallingFuncation(strDate: date)
    }
    func initConfirmOrderTableview()  {
        // layer list
        self.tblconfirmOrderList = UITableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 10 - yPosition), style: .plain)
        self.tblconfirmOrderList.delegate = self
        self.tblconfirmOrderList.dataSource = self
        self.tblconfirmOrderList.tag = 7777
        self.tblconfirmOrderList.register(totalOrderListCell.self, forCellReuseIdentifier: "totalOrderListCell")
        self.tblconfirmOrderList.separatorStyle = .singleLine
        self.tblconfirmOrderList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblconfirmOrderList.showsVerticalScrollIndicator = false
        self.tblconfirmOrderList.backgroundColor = .white
        self.tblconfirmOrderList.estimatedRowHeight = UITableView.automaticDimension
        self.tblconfirmOrderList.rowHeight = CONFIRM_CELL_HEIGHT
        self.view.addSubview(self.tblconfirmOrderList)
        self.tblconfirmOrderList.tableFooterView = UIView()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return placeorderDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: totalOrderListCell.self)) as! totalOrderListCell
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear


            let dic = placeorderDetails[indexPath.row]
            cell.btnqunty.setTitle("Qty : \(dic.totalOrderedQuantity ?? "0")", for: .normal)
            cell.lblFieldName.text = dic.productName
            cell.lblSubFieldName.text = "\(dic.salePrice ?? "") RS / 1 \(dic.unit ?? "")"
            cell.lblSubFieldTotal.isHidden = true
            cell.imgItem.sd_setImage(with: URL (string: dic.image!), placeholderImage: nil, options: .progressiveLoad)

            return cell
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - API Function
    //––––––––––––––––––––––––––––––––––––––––

    func apiCallingFuncation( strDate : String){

        WebServicesManager .productList(ordered_products: 1, search: "", onCompletion: { response in

            if response!["success"].intValue == 1 {
                let res =  response!["products"].arrayValue
                self.placeorderDetails = [OrderPlaceProduct]()
                for temp in res{
                    let value = OrderPlaceProduct.init(fromJson: temp)
                    self.placeorderDetails.append(value)
                }
                if self.tblconfirmOrderList != nil{
                    self.tblconfirmOrderList.reloadData()
                }else{
                    self.initConfirmOrderTableview()
                }
            } else {
                if self.tblconfirmOrderList != nil{
                    self.tblconfirmOrderList.isHidden = true
                    self.lblSubTitle.isHidden = false
                }
                //                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
        },onError:{ error in
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
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
