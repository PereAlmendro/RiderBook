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
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var viewHolder: UIView!
    
    static var identifier: String {
        return String(describing: HomeTableViewCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier,
                     bundle: Bundle(for: HomeTableViewCell.self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewHolder.roundCorners(radius: 5)
        shadowView.addShadow()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with viewModel: HomeCellViewModel) {
        viewHolder.addSubviewWithFillingConstraints(viewModel.view)
    }
    
}
