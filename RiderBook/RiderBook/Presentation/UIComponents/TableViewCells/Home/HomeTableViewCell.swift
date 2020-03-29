//
//  HomeTableViewCell.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

struct HomeCellViewModel {
    let view: UIView
    let row: HomeRow
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var viewHolder: UIView!
    
    // MARK: - Static constants
    
    static var identifier: String {
        return String(describing: HomeTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: HomeTableViewCell.self))
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        viewHolder.roundCorners(radius: 5)
        shadowView.addShadow()
        selectionStyle = .none
    }
    
    // MARK: - Public functions
    
    func configureCell(with viewModel: HomeCellViewModel) {
        viewHolder.addSubviewWithFillingConstraints(viewModel.view)
    }
    
}
