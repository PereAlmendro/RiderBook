//
//  BaseViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<P: BasePresenter>: UIViewController, BaseView {
    
    // MARK: - properties
    
    typealias Presenter = P
    var presenter: Presenter!
    let disposeBag = DisposeBag()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLargeTitles(true)
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    // MARK: - Public functions
    
    func enableLargeTitles(_ enable: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = enable
    }
    
    func addBackgroundImage() {
        let backgroundImage = UIImage(named: "background")?.withRenderingMode(.alwaysOriginal)
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleToFill
        view.addSubviewWithFillingConstraints(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func addRightButtonItem(systemItem: UIBarButtonItem.SystemItem) {
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem,
                                              target: self,
                                              action: #selector(rightButtonItemAction(_:)))
        rightButtonItem.tintColor = .black
        navigationItem.setRightBarButton(rightButtonItem, animated: false)
    }
    
    // MARK: - Overrideable functions
    
    @objc func rightButtonItemAction(_ sender: Any) {
        
    }
}
