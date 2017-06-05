//
//  BillCell.swift
//  Roomie
//
//  Created by iGuest on 6/4/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit


class BillCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var openNumberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}

// MARK: - Actions ⚡️
extension BillCell {
    
    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("tap")
    }
    
}
