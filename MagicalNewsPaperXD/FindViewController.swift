//
//  FindViewController.swift
//  MagicalNewsPaperXD
//
//  Created by David Mompoint on 2/1/20.
//  Copyright © 2020 PolarisOne. All rights reserved.
//

import UIKit
import Foundation

class FindViewController: UIViewController {
    @IBOutlet weak var findButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        findButton.titleLabel?.textAlignment = .center
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

