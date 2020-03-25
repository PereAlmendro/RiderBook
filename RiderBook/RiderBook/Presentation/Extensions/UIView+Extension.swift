//
//  UIView+Extension.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

extension UIView {
    func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubviewWithFillingConstraints(view)
    }
    
    func addSubviewWithFillingConstraints(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: subView.topAnchor),
            leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        ])
    }
    
    func roundCorners(radius: CGFloat = 10) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderColor = UIColor.black.cgColor
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}
