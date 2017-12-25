//
//  PopUpViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 12/17/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import UIKit

protocol PopupViewControllerDelegate: class {
    func didSelectClose(_ popupVC: PopUpViewController)
}

class PopUpViewController: UIViewController {
    weak var delegate: PopupViewControllerDelegate?
    @IBOutlet fileprivate var scrollView: UIScrollView!
    @IBOutlet fileprivate var restaurantTitle: UILabel!
    @IBOutlet fileprivate var summaryText: UITextView!
    @IBOutlet fileprivate var popUpView: UIView!
    var restaurant: Restaurant?
    
    @IBOutlet var notForMeButton: UIButton!
    @IBOutlet var okayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        restaurantTitle.text = restaurant?.name
        summaryText.text = restaurant?.description
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Burger"))
        scrollView.insertSubview(imageView, at: 0)
    }
    
    fileprivate func setupViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.popUpView.layer.cornerRadius = 15
        self.notForMeButton.layer.cornerRadius = 40
        notForMeButton.layer.borderColor = UIColor.blue.cgColor
        notForMeButton.layer.borderWidth = 1.0
        self.okayButton.layer.cornerRadius = 40
    }

    // MARK: - Navigation

    @IBAction func notForMeButtonPressed(_ sender: Any) {
        delegate?.didSelectClose(self)
    }
    
    @IBAction func okayButtonPressed(_ sender: Any) {
        // TODO: ???
    }
    
}
