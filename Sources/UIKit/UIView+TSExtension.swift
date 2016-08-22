//
//  UIView+TSExtension.swift
//  TimedSilver
//  Source: https://github.com/hilen/TimedSilver
//
//  Created by Hilen on 11/6/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    /**
     Init from nib
     Notice: The nib file name is the same as the calss name
     
     - returns: UINib
     */
    class func ts_Nib() -> UINib {
        let hasNib: Bool = NSBundle.mainBundle().pathForResource(self.ts_className, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter") // assert
            return UINib()
        }
        return UINib(nibName: self.ts_className, bundle:nil)
    }
    
    /**
     Init from nib and get the view
     Notice: The nib file name is the same as the calss name
     
     - parameter aClass: your class
     
     - returns: Your class's view
     */
    class func ts_viewFromNib<T>(aClass: T.Type) -> T {
        return self.ts_Nib().instantiateWithOwner(nil, options: nil)[0] as! T
    }

    /**
     All subviews of the UIView
     
     - returns: A group of UIView
     */
    func ts_allSubviews() -> [UIView] {
        var stack = [self]
        var views = [UIView]()
        while !stack.isEmpty {
            let subviews = stack[0].subviews as [UIView]
            views += subviews
            stack += subviews
            stack.removeAtIndex(0)
        }
        return views
    }
    
    /**
     Take snap shot
     
     - returns: UIImage
     */
    func ts_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Check the view is visible
    var ts_visible: Bool {
        get {
            if self.window == nil || self.hidden || self.alpha == 0 {
                return true
            }
            
            let viewRect = self.convertRect(self.bounds, toView: nil)
            guard let window = UIApplication.sharedApplication().keyWindow else {
                return true
            }
            return CGRectIntersectsRect(viewRect, window.bounds) == false
        }
    }
}







