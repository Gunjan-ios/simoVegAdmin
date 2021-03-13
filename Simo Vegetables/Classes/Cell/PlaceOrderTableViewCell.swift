//
//  PlaceOrderTableViewCell.swift
//  Simo Vegetables
//
//  Created by Apple on 10/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit

class PlaceOrderTableViewCell: UITableViewCell ,UITextFieldDelegate{

    var delegate : UpdatePriceController?

    var btnqunty : UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentHorizontalAlignment = .center
        btn.titleLabel?.font = UIFont (name: APP_FONT_NAME_BOLD, size: 15)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    var imgItem : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    var lblFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: APP_FONT_NAME_BOLD, size: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    var lblSubFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: APP_FONT_NAME, size: 15)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()

    var txtbuyquanty :  OrderTextfiled = {
        let txt = OrderTextfiled()
        txt.keyboardType = .numberPad
        txt.textColor = .black
//        txt.layer.borderWidth = 1
//        txt.layer.borderColor = UIColor.gray.cgColor

        return txt
    }()
    var txtPurchaseQuanty :  OrderTextfiled = {
        let txt = OrderTextfiled()
        txt.keyboardType = .numberPad
        txt.textColor = .black
        return txt
    }()


    var txtsellquanty :  OrderTextfiled = {
        let txt = OrderTextfiled()
        txt.keyboardType = .numberPad
        txt.textColor = .black
        //        txt.layer.borderWidth = 1
        //        txt.layer.borderColor = UIColor.gray.cgColor
        return txt
    }()
    var lblunitNote: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: APP_FONT_NAME, size: 12)
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
//        label.backgroundColor = .blue
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    var subView : UIView = {
        let view = UIView()
//        view.layer.cornerRadius = radius
//        view.backgroundColor = .white
//        view.layer.masksToBounds = true
//        // set the shadow properties
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = .zero
//        view.layer.shadowOpacity = 0.3
//        view.layer.shadowRadius = 5.0
//        view.layer.masksToBounds =  false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.systemGray4

        subView.frame = CGRect (x: X_PADDING, y: Y_PADDING , width: SCREEN_WIDTH - X_PADDING*2, height: Int(TABLEVIEW_CELL_HEIGHT) - X_PADDING)

        imgItem.frame = CGRect (x: Y_PADDING, y: 15, width: 40, height: 40)
        //        imgItem.center = CGPoint (x: subView.frame.origin.x, y: imgItem.frame.origin.y)

        let xPosition = 54
        var yPosition = 0

        self.lblFieldName.frame = CGRect(x: xPosition, y: yPosition, width: SCREEN_WIDTH - xPosition , height: Order_CELL_LABEL_HEIGHT)

        yPosition +=  Int(lblFieldName.bounds.height )

        let devidedWidth = Int(subView.frame.width) - xPosition - X_PADDING

        self.txtbuyquanty.frame = CGRect(x: xPosition, y:yPosition , width:  devidedWidth/2, height: Order_CELL_LABEL_HEIGHT)
//        self.txtPurchaseQuanty.frame =  CGRect (x: Int(txtbuyquanty.frame.maxX) + Y_PADDING, y: yPosition , width:  devidedWidth/3 , height: Order_CELL_LABEL_HEIGHT)
        self.txtsellquanty.frame =  CGRect (x: Int(subView.frame.width) - devidedWidth/2 , y: yPosition , width:  devidedWidth/2  , height: Order_CELL_LABEL_HEIGHT)


        self.lblSubFieldName.isHidden = true

//        self.lblSubFieldTotal.frame = CGRect(x: xPosition, y:yPosition , width: SCREEN_WIDTH - xPosition , height: CELL_LABEL_HEIGHT)

        addSubview(subView)
        subView.addSubview(imgItem)
        subView.addSubview(btnqunty)
        subView.addSubview(lblFieldName)
        subView.addSubview(txtsellquanty)
        subView.addSubview(txtbuyquanty)
//        subView.addSubview(txtPurchaseQuanty)
        subView.addSubview(lblunitNote)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }


    func textFieldDidBeginEditing(_textField: UITextField) {
        print("rese")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

//        delegate?.getData()
    }

}
