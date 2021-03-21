//
//  OrderViewController.swift
//  Simo Vegetables
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit
import LUExpandableTableView

class CustomerWiseOrderViewController: ParentClass {

    fileprivate var headerview:UIView!
    fileprivate var yPosition: Int!
    fileprivate var buttonBack: CustomButton!
    fileprivate var buttonDate : CustomComboBoxView!
    fileprivate var mainView  : UIView!
    fileprivate var topView : UIView!

//    fileprivate var tblList: UITableView!
    private var tblList : LUExpandableTableView!

    var orderAmount  : CustomLabel!
    var orderDate  : CustomLabel!
    var orderName  : CustomLabel!


    var orderDetails : [OrderListOrder]! = [OrderListOrder]()

    var  strDate : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        strDate  = dateFormatter.string(from: Date())
        loadHeaderView()
                // Do any additional setup after loading the view.
    }
    func loadHeaderView() {

        yPosition = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)

        headerview = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)

        let buttonTitle = CustomButton(frame: CGRect(x: 0 , y: 0, width: SCREEN_WIDTH , height: NAV_HEADER_HEIGHT))
        buttonTitle.setTitle("Customer wise order", for: .normal)
        buttonTitle.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        buttonTitle.contentHorizontalAlignment = .center
        headerview.addSubview(buttonTitle)

        yPosition += Int(headerview.bounds.height) + Y_PADDING

        buttonDateView()
    }

    func buttonDateView(){

        buttonDate = CustomComboBoxView(frame: CGRect (x: SCREEN_WIDTH - 140, y: yPosition, width: 130, height: NAV_HEADER_HEIGHT))
        buttonDate.delegateApp = self
        buttonDate.initDesign(pName:Date.yesterday.convertToDateString, pTag: 1, pOptions: [], pPlaceHolder: "Select Date")
        buttonDate.setDatePicker()
        self.view.addSubview(buttonDate)

        yPosition += Int(buttonDate.bounds.height)


    }
    override func viewWillAppear(_ animated: Bool) {
        apiCallingFuncation(strDate: buttonDate.txtField.text!)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - API Function
    //––––––––––––––––––––––––––––––––––––––––

    func apiCallingFuncation( strDate : String){

        WebServicesManager .orderList(user_id: ConnflixUtilities.shared.UserID!, order_date: strDate, view: self.view, onCompletion: { response in
            if response!["success"].intValue == 1 {
                let res =  response!["orders"].arrayValue
                self.orderDetails.removeAll()
                for temp in res{
                    let value = OrderListOrder.init(fromJson: temp)
                    self.orderDetails.append(value)
                }
                if self.tblList == nil{
                    self.initTableview()
                }else{
                    self.tblList.isHidden = false
                    self.tblList.reloadData()
                }
            } else {
                if self.tblList != nil{
                    self.tblList.isHidden = true
                }
                self.lblSubTitle.isHidden = false

                self.showAlert(message: response!["message"].stringValue, type: AlertType.error, navBar: false)
            }
        },onError:{ error in
            if error != nil {
                self.showAlert(message:  CS.Common.wrongMsg, type: AlertType.error, navBar: false)
            }
        })
    }

    func getSelectDate(date : String){
        apiCallingFuncation(strDate: date)
    }

    func initTableview()  {
        // layer list
        self.tblList = LUExpandableTableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition), style: .insetGrouped)
        self.tblList.tag = 9999
        self.tblList.register(OrderListCell.self, forCellReuseIdentifier: "OrderListCell")
        tblList.register(UINib(nibName: "MyExpandableTableViewSectionHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "MySectionHeader")
        tblList.expandableTableViewDataSource = self
        tblList.expandableTableViewDelegate = self
        self.tblList.separatorStyle = .singleLine
        self.tblList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = .white
        self.tblList.estimatedRowHeight = UITableView.automaticDimension
        self.tblList.rowHeight = TABLEVIEW_CELL_HEIGHT
        self.view .addSubview(self.tblList)

    }
}
extension CustomerWiseOrderViewController: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return orderDetails.count
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails[section].items.count
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblList.dequeueReusableCell(withIdentifier: String(describing: OrderListCell.self)) as! OrderListCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = .systemGray6

        let dic = orderDetails[indexPath.section].items[indexPath.row]
//        cell.btnqunty.setTitle("Qty : \(dic.quantity ?? "0")", for: .normal)
        cell.btnqunty.setTitle("Qty : \(dic.quantity ?? "0") \(dic.unit ?? "-")", for: .normal)

        cell.lblFieldName.text = dic.productName
        cell.lblSubFieldName.text = "\(dic.salePrice ?? "-") RS / 1 \(dic.unit ?? "-")"
        cell.lblSubFieldTotal.text = "Subtotal : \(dic.totalSalePrice ?? "-") RS"
        cell.imgItem.sd_setImage(with: URL (string: dic.image!), placeholderImage: nil, options: .progressiveLoad)

        return cell
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: "MySectionHeader") as? MyExpandableTableViewSectionHeader else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        } 

        sectionHeader.name.text = "\(orderDetails[section].firstName ?? "")" + "\(orderDetails[section].lastName ?? "")"
        sectionHeader.address.text = orderDetails[section].address
        sectionHeader.orderName.text = orderDetails[section].orderNumber
        sectionHeader.orderDate.text = "\(orderDetails[section].orderPlacedOn ?? "")"
        sectionHeader.ordertotal.text = "Total Amount : \(orderDetails[section].orderAmount ?? "-") RS"
        sectionHeader.expandCollapseButton.setTitle("Total Item : \(orderDetails[section].totalItems ?? 0)", for: .normal)

        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension CustomerWiseOrderViewController: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 90.0
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 100.0
    }

    // MARK: - Optional

    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        print("Did select section header at section \(section)")
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        print("Will display section header for section \(section)")
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }


    func expandableTableView(_ expandableTableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
