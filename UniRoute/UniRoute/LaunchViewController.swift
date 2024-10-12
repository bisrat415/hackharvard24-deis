//
//  LaunchViewController.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the UIImageView to fill the entire screen
        let launchImageView = UIImageView(frame: UIScreen.main.bounds)
        launchImageView.image = UIImage(named: "Launch")
        launchImageView.contentMode = .scaleAspectFill
        launchImageView.clipsToBounds = true

        self.view.addSubview(launchImageView)
        self.view.sendSubviewToBack(launchImageView)
    }
}
