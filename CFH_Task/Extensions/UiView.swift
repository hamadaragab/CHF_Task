//
//  UiView.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

class ShadowView: UIView {
    @IBInspectable var theCornerRadius:CGFloat = 10.0 {didSet{setupCoreners()}}
    @IBInspectable var topLeft:Bool = true {didSet{setupCoreners()}}
    @IBInspectable var topRight:Bool = true {didSet{setupCoreners()}}
    @IBInspectable var bottomLeft:Bool = true {didSet{setupCoreners()}}
    @IBInspectable var bottomRight:Bool = true {didSet{setupCoreners()}}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.7
        setupCoreners()
    }
    
    private func setupCoreners() {
        var corners: UIRectCorner = []
        if topLeft {
            corners.insert(.topLeft)
        }
        if topRight {
            corners.insert(.topRight)
        }
        if bottomLeft {
            corners.insert(.bottomLeft)
        }
        if bottomRight {
            corners.insert(.bottomRight)
        }
        if #available(iOS 11.0, *) {
            layer.cornerRadius = theCornerRadius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: theCornerRadius, height: theCornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
