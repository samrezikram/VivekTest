//
//  OfflineViewController.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/21.
//  Copyright © 2018 Samrez Ikram. All rights reserved.
//
import UIKit

class OfflineViewController: UIViewController {
    
    let network = InternetConnectionManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        network.reachability.whenReachable = { reachability in
            self.showMainController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func showMainVC(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    private func showMainController() -> Void {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
}
