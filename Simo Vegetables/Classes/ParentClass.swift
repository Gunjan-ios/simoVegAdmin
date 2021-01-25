//
//  ParentViewController.swift
//  GEM
//
//  Created by Gunjan Raval on 8/23/18.
//  Copyright © 2018 Gunjan Raval. All rights reserved.
//

import UIKit
import LIHAlert
import SwiftyJSON
//import KOLocalizedString
import SDWebImage

class ParentClass: UIViewController{
   
    static let sharedInstance = ParentClass()

    // ----------------------------------------------------------
    // MARK: Private Members
    // ----------------------------------------------------------
    
    var alert: LIHAlert?
    var processingAlert: LIHAlert?
    var alertNoNavBar: LIHAlert?
    var APP = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var iPhone_SE:Bool = false
    var iPhone_X_Top_Padding:CGFloat = 0
    var iPhone_X_Bottom_Padding:Int! = 0
    var token : String!
    var saveListArray : [[String : Any]] = [[String:Any]]()
    var saveListArray1 : [JSON] = [JSON]()
//    var tempArray : [JSON] = [JSON]()
    var editListArray1 : [JSON] = [JSON]()
    var UDID : String!
    var lblSubTitle : UILabel!
    var userDic : User!
    var tab : ESTabBarController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initAlerts()

        self.view.backgroundColor = colorPrimary
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        self.navigationController?.isNavigationBarHidden = true
        let imgNav = UIView (frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: STATUS_BAR_HEIGHT))
        imgNav.backgroundColor = colorPrimary
        self.view.addSubview(imgNav)
        
        
       if APP.open_count == 1{
        APP.open_count = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        }
        self.lblSubTitle = UILabel (frame: CGRect (x: X_PADDING, y: 0, width: SCREEN_WIDTH - X_PADDING*2, height: SCREEN_HEIGHT))
        //            lblSubTitle.center = CGPoint (x: self.view.center.x, y: lblSubTitle.center.y)
        self.lblSubTitle.text =  CS.Common.NoData
        self.lblSubTitle.numberOfLines = 0
        self.lblSubTitle.lineBreakMode = .byWordWrapping
        self.lblSubTitle.textAlignment = .center
        self.lblSubTitle.font = UIFont (name: APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        self.lblSubTitle.textColor = .black
        self.lblSubTitle.isHidden = true
        self.view.addSubview(self.lblSubTitle)
        let str = ParentClass.sharedInstance.getJSON(CS.Saved.userData)
        if str != nil{
//            self.userDic = User (fromJson:str )
        }
    }
    
    func customBouncesStyle() -> UIViewController {
        tab = ESTabBarController()
        let v1 = OrderTotalItemViewController()
        let v2 = CustomerWiseOrderViewController()
        let v3 = UpdatePriceController()
        let v4 = MoreViewController()
        tab.tabBar.barTintColor = UIColor .init(white: 0.9, alpha: 1)
        v1.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Order total items", image: UIImage(named: "purchase-order"), selectedImage: UIImage(named: "purchase-order"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Customerwise Order", image: UIImage(named: "customer"), selectedImage: UIImage(named: "customer"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Update Price", image: UIImage(named: "note"), selectedImage: UIImage(named: "note"))
        v4.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "More", image: UIImage(named: "tabSetting"), selectedImage: UIImage(named: "tabSetting_1"))

        tab.viewControllers = [v1, v2, v3,v4]

        tab.title = ""
        tab.tabBar.backgroundColor = .white
        return tab
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setData(strData:Any,strKey:String) {
        
        UserDefaults.standard.set(strData, forKey: strKey)
        UserDefaults.standard.synchronize()
    }
    
    func getDataForKey(strKey:String) -> Any {
        return UserDefaults.standard.value(forKey: strKey) as Any
    }
    
    func detectScreenShot(action: @escaping () -> ()) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { notification in
            // executes after screenshot
            action()
        }
    }
    
    func getDate(date:String)-> String {
        if (date == ""){
            return date
        }
        let splitdate : [Substring] = date.split(separator: ".")
        let subString = splitdate.first!
        let newDate = String(subString)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date1 = dateFormatterGet.date(from:newDate ){
            dateFormatterPrint.timeZone = TimeZone.current
            dateFormatterPrint.timeStyle = .medium //Set time style
            dateFormatterPrint.dateStyle = .medium //Set date style
//            dateFormatterPrint.dateFormat = "yyyy-MM-dd  HH:mm:ss"
            return dateFormatterPrint.string(from:date1)
        }
        else {
            print("There was an error decoding the string")
        }
        return date
    }
    func dateConvert(date: Double?) -> String{
        
        if let timeResult = date {
            let date = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium //Set time style
            dateFormatter.dateStyle = .medium //Set date style
            let localDate = dateFormatter.string(from: date as Date)
            return localDate
        }else{
            return ""
        }
    }
//    func getDataJSON(key:String) -> [Video] {
//        if let listArray = self.getDataForKey(strKey: key) as? Data {
//            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [Video] {
//                return decodedArray
//            }
//        }
//        return [Video]()
//    }
//
//    func setJSON(json: [Video], key:String)  {
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject:json)
//        self.setData(strData: encodedData, strKey: key)
//    }
    func saveJSON(json: JSON, key:String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }
    
    func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
//    public func loadJSON(strKey:String) -> JSON {
//        let defaults = UserDefaults.standard
//        return JSON (parseJSON: (defaults.value(forKey: strKey) as! String))
////        return JSON.parse(defaults.valueForKey(strKey) as! String))
//        // JSON from string must be initialized using .parse()
//    }
    // get color from string
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        if (toInterfaceOrientation.isLandscape) {
            NSLog("Landscape");
        }
        else {
            NSLog("Portrait");
        }
    }
    func getColorFromString(pString:String) -> UIColor {
        
        var strokeColorInString = pString
        strokeColorInString = strokeColorInString.replacingOccurrences(of: "rgba(", with: "")
        strokeColorInString = strokeColorInString.replacingOccurrences(of: ")", with: "")
        
        let strokesArray = strokeColorInString.components(separatedBy: ",")
        
        return UIColor(red:  CGFloat(Double(strokesArray[0])!/255.0), green: CGFloat(Double(strokesArray[1])!/255.0), blue: CGFloat(Double(strokesArray[2])!/255.0), alpha:  CGFloat(Double(strokesArray[3])!))
    }
    @objc func networkStatusChanged(_ notification: Notification) {

        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            APP.open_count = 2
//           self.processingAlert?.show(nil, hidden: nil)
         case .online(.wwan):
            print("Connected via WWAN")
            self.processingAlert?.hideAlert({ () -> () in
                if self.APP.open_count == 2 {
                    self.APP.open_count = 0
//                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
                }
                    })
        case .online(.wiFi):
            print("Connected via WiFi")

            self.processingAlert?.hideAlert({ () -> () in
                if self.APP.open_count == 2 {
                    self.APP.open_count = 0
//                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
                }
                    })
        }
    }
    
    func initAlerts() {
        self.alert = AlertManager.getErrorAlert()
        self.alertNoNavBar = AlertManager.getErrorAlertNoNavBar()
        self.processingAlert = AlertManager.FetchErrorAlert()
        self.alert?.initAlert(self.view)
        self.alertNoNavBar?.initAlert(self.view)
        self.processingAlert?.initAlert(self.view)
    }

    
    func showAlert(message: String, type: AlertType, navBar: Bool) {

        let alt = navBar ? alert : alertNoNavBar

        if type == AlertType.success {
            alt?.alertColor = AlertManager.successColor
        } else if type == AlertType.error {
            alt?.alertColor = AlertManager.errorColor
        }
        alt?.contentText = message
        alt?.show(nil, hidden: nil)
    }
    
    func showAlert(title: String?, message: String?, yesAction: UIAlertAction, noAction: UIAlertAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.showDetailViewController(alert, sender: self)
    }
    
    
    func heightForView(text:String?, width:CGFloat , Label : CustomLabel) -> Int{
        let hValue = CGFloat.greatestFiniteMagnitude
        Label.frame.size.height = hValue
        Label.numberOfLines = 0
        Label.lineBreakMode = NSLineBreakMode.byWordWrapping
        Label.text = text
        Label.sizeToFit()
        //if Int(Label.frame.height) < LABEL_HEIGHT || Int(Label.frame.height)  <= 41 {
        
        if Int(Label.frame.height) < CUSTOM_TEXTFIELD_HEIGHT  {
            return CUSTOM_TEXTFIELD_HEIGHT
        }
        else{
            return Int(Label.frame.height)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Actions -
    //––––––––––––––––––––––––––––––––––––––––
    /// Function for change localization
   
//    func OnLanguagePressed() {
//        let alertController = UIAlertController(title: KOLocalizedString(Language.Common.ChooseLanguage), message: nil, preferredStyle: .actionSheet)
//        
//        let EnglishAction = UIAlertAction(title: KOLocalizedString(Language.Common.English), style: .default) { action in
//            KOSetLanguage("en")
//        }
//        alertController.addAction(EnglishAction)
//        
//        let HindiAction = UIAlertAction(title: KOLocalizedString(Language.Common.Hindi), style: .default) { action in
//            KOSetLanguage("hi")
//        }
//        
//        alertController.addAction(HindiAction)
//        
//        let cancelAction = UIAlertAction(title: KOLocalizedString(Language.Common.Cancel), style: .cancel) { action in }
//        alertController.addAction(cancelAction)
//        
//        self.present(alertController, animated: true)
//    }

    
    
}
