//
//  AutoFontSizeSetter.swift
//  AutoFontSizeSetter
//
//  Created by anna on 11/20/1397 AP.
//  Copyright © 1397 abbaspour. All rights reserved.
//

import Foundation
import  UIKit


///This class automaticly works for UILabel, UITextView, UITextField, UIButton and objects that inhertice from them.
///
///  Other objects must be writen by programmer(like: UIPickerView, UISegmentedControl, UITabBarItem ... )
class FontSizer{

   static let shared:FontSizer=FontSizer()
    ///Should be true to start working in AppDelegate
    internal var isActive:Bool = false
    ///Tags with this number will not change, default is value 666
    ///you can change it to any number, 0 does't count
    internal var exceptionTag = 666
    
    ///following argument specifes how much of current font size should increase or decrease
    ///depending on iphone heights
    ///
    ///Example:
    ///
    ///AutoFontSizeSetter.shared.defaultIphoneSize =
    ///
   ///[480:-2,  //iphone 4
    ///
   /// 568 :-1,  //iphone SE
    ///
   /// 667 :0,   //iphone 6
    ///
   /// 736 :1,   //iphone 6 Plus
    ///
   /// 812 :0,   //iphone X
    ///
   /// 896 :1    //iphone XR
    ///   ]
    /// - WARNING: if you don't declure or miss any size, default value will  be used
    internal var iphoneSizes:[CGFloat:CGFloat] = [:]
    
   ///Useing this function to get increament or
   ///decreament value for current font size
    internal func findIphoneSize() -> CGFloat{
        
        let sharedFontSize = FontSizer.shared
        let defaultIphoneSize:[CGFloat:CGFloat] =
            [480:-2,  //iphone 4
                568 :-1,  //iphone SE
                667 :0,   //iphone 6
                736 :1,   //iphone 6 Plus
                812 :0,   //iphone X
                896 :1    //iphone XR
        ]
        
        if (sharedFontSize.iphoneSizes.count == 0){
            sharedFontSize.iphoneSizes = defaultIphoneSize
        }else{
            for item in defaultIphoneSize{
                if sharedFontSize.iphoneSizes[item.key] == nil{
                    sharedFontSize.iphoneSizes[item.key] = item.value
                }}}
        let thisIphone = UIScreen.main.bounds.height
        switch thisIphone {
        case _ where  thisIphone <= 480 :
            return sharedFontSize.iphoneSizes[480]!
        case _ where  thisIphone <= 568 :
            return sharedFontSize.iphoneSizes[568]!
        case _ where  thisIphone <= 667 :
            return sharedFontSize.iphoneSizes[667]!
        case _ where  thisIphone <= 736 :
            return sharedFontSize.iphoneSizes[736]!
        case _ where  thisIphone <= 812 :
            return sharedFontSize.iphoneSizes[812]!
        case _ where  thisIphone > 812 :
            return sharedFontSize.iphoneSizes[896]!
            
        default:
            print("AutoFontSizeSetter:Error -> did't declure size inside /n AutoFontSizeSetter.shared.iphoneSizes in AppDelegate")
            return 0
        }
        
    }
}

//,segment,picker,navigationbar,tabbar,toolbar ,bar button item




extension UILabel{
    open override func awakeFromNib() {
        if FontSizer.shared.isActive &&
            self.tag != FontSizer.shared.exceptionTag{
            let size = FontSizer.shared.findIphoneSize()
            let currentSize = self.font.pointSize
            self.font = UIFont(name: self.font.fontName, size: currentSize + size )
        }
    }
}

extension UITextField{
    open override func awakeFromNib() {
        if FontSizer.shared.isActive &&
            self.tag != FontSizer.shared.exceptionTag{
            let size = FontSizer.shared.findIphoneSize()
            if let font = self.font {
            let currentSize = font.pointSize
            self.font = UIFont(name: font.fontName, size: currentSize + size )
            }}
    }
}

extension UITextView{
    open override func awakeFromNib() {
        if FontSizer.shared.isActive &&
            self.tag != FontSizer.shared.exceptionTag{
            let size = FontSizer.shared.findIphoneSize()
            if let font = self.font {
                let currentSize = font.pointSize
                self.font = UIFont(name: font.fontName, size: currentSize + size )
            }}
    }
}

extension UIButton{
    open override func awakeFromNib() {
        if FontSizer.shared.isActive &&
            self.tag != FontSizer.shared.exceptionTag{
            let size = FontSizer.shared.findIphoneSize()
            let currentSize = self.titleLabel?.font.pointSize
            self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: currentSize! + size )
        }
    }
}






