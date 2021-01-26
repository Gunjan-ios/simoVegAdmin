//
//  Extensions.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import UIKit

extension UITextField {

	func notEmpty() -> Bool {

		if let txt = self.text {

			let trimmedString = txt.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

			if trimmedString != "" {
				return true
			}
		}

		return false
	}
    func leftImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }

}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIButton {
    
    func centerVertically(padding: CGFloat = 6.0,totalWidth : CGFloat) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -(imageViewSize.width),
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0
        )
    }
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    convenience init (hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
    
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
}
extension UIView {
    
    func view(withId id: String) -> UIView? {
        
        for view in self.subviews {
            if view.tag == Int(id) {
                return view
            }
        }
        return nil
    }
}

extension String {
    
    var integer: Int {
        return Int(self) ?? 0
    }
    
    var secondFromString : Int{
        var components: Array = self.components(separatedBy: ":")
        let hours = components[0].integer
        let minutes = components[1].integer
        let seconds = components[2].integer
        return Int((hours * 60 * 60) + (minutes * 60) + seconds)
    }

        var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
	func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}

	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}

	func index(from: Int) -> Index {
		return self.index(startIndex, offsetBy: from)
    }
    
   

	subscript(_ range: NSRange) -> String {
		let start = self.index(self.startIndex, offsetBy: range.lowerBound)
		let end = self.index(self.startIndex, offsetBy: range.upperBound)
		let subString = self[start..<end]
		return String(subString)
	}

	func width(width: CGFloat, font: UIFont) -> CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = self
		label.sizeToFit()

		return label.frame.height
	}
}

extension UISegmentedControl {
	func removeBorders() {
		setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
		setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
		setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
	}

	// create a 1x1 image with this color
	private func imageWithColor(color: UIColor) -> UIImage {
		let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		context!.setFillColor(color.cgColor);
		context!.fill(rect);
		let image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return image!
	}
}

extension UIScrollView {

	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesBegan(touches, with: event)
		} else {
			self.superview?.touchesBegan(touches, with: event)
		}
	}

	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)    {
		if self.isDragging {
			super.touchesCancelled(touches, with: event)
		} else {
			self.superview?.touchesCancelled(touches, with: event)
		}
	}

	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesEnded(touches, with: event)
		} else {
			self.superview?.touchesEnded(touches, with: event)
		}
	}

	override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesMoved(touches, with: event)
		} else {
			self.superview?.touchesMoved(touches, with: event)
		}
	}
}

extension UITextView{
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        let fixedWidth = arg.frame.size.width
        let newSize = arg.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        arg.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        arg.isScrollEnabled = false
        arg.sizeToFit()
    }
}

extension UIImage
{
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    // convenience function in UIImage extension to resize a given image
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage
    {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return copied!
    }
    func jpeg(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)

//        return UIImageJPEGRepresentation(self, quality.rawValue)
        
//        return UIImagePNGRepresentation(self)
        
    }
}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
