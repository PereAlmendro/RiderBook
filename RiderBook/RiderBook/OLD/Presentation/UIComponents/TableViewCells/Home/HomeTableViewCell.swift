//
//  HomeTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    
    static var identifier: String {
        return String(describing: HomeTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: HomeTableViewCell.self))
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var viewHolder: UIView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        viewHolder.roundCorners(radius: 5)
        shadowView.addShadow()
        selectionStyle = .none
    }
    
    // MARK: - Public functions
    
    func configureCell(with view: UIView) {
        viewHolder.addSubviewWithFillingConstraints(view)
    }
    
}
