//
//  CustomComboBoxView.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomComboBoxView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    private var labelTitle:UILabel! = nil
    private let pickerView = DropDownPickerView()
    var txtField:CustomTextFieldForAttribute!
    private var datePickerView:UIDatePicker? = nil
    var delegateApp:CustomerWiseOrderViewController?
    var delegateOrder:OrderTotalItemViewController?


    let txtFieldHeight = 40

    func initDesign(pName:String,pTag:Int,pOptions:[String],pPlaceHolder:String) {

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemGreen
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForForDropDownTypePickerView(sender:)))
        doneButton.tag = 5000 + pTag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        pickerView.tag = 5000 + pTag

        let dropDownOptions = pOptions
        print(pOptions)
        pickerView.pickerOptions = dropDownOptions
        pickerView.delegate = self as UIPickerViewDelegate
        self.txtField = CustomTextFieldForAttribute(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: txtFieldHeight))
        self.txtField.delegate = self as UITextFieldDelegate
        self.txtField.tag = pTag
        self.txtField.text = pName
        self.txtField.returnKeyType = .done
        self.txtField.placeholder = pPlaceHolder
        self.txtField.attributedPlaceholder = NSAttributedString(string: pPlaceHolder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.txtField.inputView = pickerView
        self.txtField.inputAccessoryView = toolBar
//        self.txtField.imgIcon.frame = CGRect(x: 0, y: 0, width: txtFieldHeight, height: txtFieldHeight)

        self.addSubview(self.txtField)

        pickerView.currentTextField = txtField
    }

    //MARK:- Date Picker
    func setDatePicker() {

        self.pickerView.isHidden = true

        // for date picker
        self.datePickerView = UIDatePicker()
        self.datePickerView!.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            self.datePickerView?.preferredDatePickerStyle = .wheels
        }
        self.datePickerView!.maximumDate = Date()
        self.datePickerView!.addTarget(self, action: #selector(datePickerForDateValueChanged(sender:)), for: .valueChanged)
        self.txtField.inputView = self.datePickerView

        // for done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemGreen
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForDateTypePickerView(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.txtField.inputAccessoryView = toolBar

    }

    @objc private func datePickerForDateValueChanged(sender:UIDatePicker) {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.txtField.text = dateFormatter.string(from: sender.date)
    }

    @objc func donePressedForDateTypePickerView(sender:UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dtPicker = self.txtField.inputView as! UIDatePicker
        self.txtField.text = dateFormatter.string(from: dtPicker.date)
        self.txtField.resignFirstResponder()
        if let delegate = self.delegateApp {
            delegate.getSelectDate(date: self.txtField.text!)
         }
        if let delegate = self.delegateOrder {
            delegate.getSelectDate(date: self.txtField.text!)
        }
    }

    //MARK:- Dropdown delegate
    @objc func donePressedForForDropDownTypePickerView(sender:UIBarButtonItem) {
            self.txtField.text = self.pickerView.pickerOptions[self.pickerView.selectedRow(inComponent: 0)]
            self.txtField.resignFirstResponder()
    }

    // MARK: UIPickerView Delegation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //  self.selectedIndexForPickerView = row
        let pickerView = pickerView as! DropDownPickerView
        pickerView.currentTextField.text = pickerView.pickerOptions[row]
    }

    //MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

//        if let delegate = self.delegateAppForm {
//            delegate.textFieldDidBeginEditing_VC(textField)
//        }
    }


}
