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

    /// Random status
    var randomStatus: BTStatus!
    private var statusHistory: [BTStatus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        BTAssessmentSDK.shared.delegate = self
        
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
            
            
            self.statusHistory.insert(randomStatus, at: 0)
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

