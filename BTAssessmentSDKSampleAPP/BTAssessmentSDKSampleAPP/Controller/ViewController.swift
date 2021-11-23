//
//  ViewController.swift
//  BTAssessmentSDKSampleAPP
//
//  Created by Vangelis Spirou Bespot on 4/10/21.
//

import UIKit
import BTAssessmentSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subscribeButton: UIButton!
    
    /// Keep current random status in separate variable
    var randomStatus: BTStatus!
    /// An array from BTStatus objects keeping historical values of inout status
    private var statusHistory: [BTStatus] = []
    
    // Get a reference to the app delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable/disable the subscribe button based on our status
        subscribeButtonConfiguration()
        
        // Set the UITableView delegate
        tableView.delegate = self
        // Set the UITableView dataSource
        tableView.dataSource = self
        
        // Set the BTAssessmentSDK InOut delegate
        BTAssessmentSDK.shared.inOutDelegate = self
        
    }
    
    fileprivate func subscribeButtonConfiguration() {
        let isAuthenticatedSuccessful = appDelegate.isAuthenticated
        
        if isAuthenticatedSuccessful {
            // Enable the user interaction
            self.subscribeButton.isUserInteractionEnabled = true
        } else {
            self.subscribeButton.backgroundColor = .systemGray
            // Disable the user interaction
            self.subscribeButton.isUserInteractionEnabled = false
        }
    }

    @IBAction func subscribeOrUnsubscribe(_ sender: UIButton) {
        
        if sender.currentTitle == "Subscribe" {
            
            BTAssessmentSDK.shared.subscribe()
            sender.setTitle("Unsubscribe", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .systemRed
        } else if sender.currentTitle == "Unsubscribe" {
            
            BTAssessmentSDK.shared.unsubscribe()
            sender.setTitle("Subscribe", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .systemGreen
        }
        
    }
    
}

extension ViewController: BTInOutDelegate {
    
    func didUpdateResult(status: BTStatus) {
        
        DispatchQueue.main.async { [self] in
            switch status.status {
            case .inside:
                randomStatus = status
            case .outside:
                randomStatus = status
            }
            
            // Insert status object to history array
            self.statusHistory.insert(randomStatus, at: 0)
            
            // Update table view
            self.tableView.reloadData()
        }
        
    }
    
    func didFailUpdate(error: BTError) {
        
        print(error.description)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InOutCell", for: indexPath) as? InOutCell else {
            return UITableViewCell()
        }
        
        let myCurrentStatus = statusHistory[indexPath.row]
        cell.configureUI(status: myCurrentStatus)
        return cell
    }
    
}

