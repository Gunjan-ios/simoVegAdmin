//
//  ConfirmOrderTableViewCell.swift
//  Simo Vegetables
//
//  Created by Apple on 17/01/21.
//  Copyright © 2021 Gunjan. All rights reserved.
//

import UIKit

class ConfirmOrderTableViewCell: UITableViewCell {

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

    var lblSubFieldTotal : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: APP_FONT_NAME_BOLD, size: 15)
        label.textAlignment = .left
        label.textColor = .gray
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

        subView.frame = CGRect (x: X_PADDING, y: Y_PADDING , width: SCREEN_WIDTH - X_PADDING*2, height: Int(CONFIRM_CELL_HEIGHT) - X_PADDING)

        imgItem.frame = CGRect (x: Y_PADDING, y: 10, width: 40, height: 40)
        //        imgItem.center = CGPoint (x: subView.frame.origin.x, y: imgItem.frame.origin.y)

        let xPosition = 54
        var yPosition = 20

        self.lblFieldName.frame = CGRect(x: xPosition, y: yPosition, width: SCREEN_WIDTH - xPosition , height: CELL_LABEL_HEIGHT)
        self.btnqunty.frame = CGRect (x: SCREEN_WIDTH - X_PADDING -  130 , y: yPosition , width: 120, height: CELL_LABEL_HEIGHT)
        yPosition +=  Int(btnqunty.bounds.height)

        addSubview(subView)
        subView.addSubview(imgItem)
        subView.addSubview(btnqunty)
        subView.addSubview(lblFieldName)
        subView.addSubview(lblSubFieldName)
        subView.addSubview(lblSubFieldTotal)

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

}
