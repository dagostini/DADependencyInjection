//
//  DetailsViewController.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/05/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    public var itemTitle: String?
    public var itemDescription: String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = itemTitle
        self.detailsLabel.text = itemDescription
    }

    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
