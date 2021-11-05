//
//  InOutCell.swift
//  BTAssessmentSDKSampleAPP
//
//  Created by Vangelis Spirou Bespot on 11/10/21.
//

import UIKit
import BTAssessmentSDK

class InOutCell: UITableViewCell {
    
    @IBOutlet weak var inOutCellView: UIView!
    @IBOutlet weak var inOutCellLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// This method configure the UI of cell
    func configureUI(status: BTStatus) {
        
        if status.status == .inside {
            inOutCellView.backgroundColor = .systemGreen
            inOutCellLabel.text = status.statusDescription
        } else if status.status == .outside {
            inOutCellView.backgroundColor = .systemRed
            inOutCellLabel.text = status.statusDescription
        }
        inOutCellView.layer.cornerRadius = 5.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 5.0
    }

}
