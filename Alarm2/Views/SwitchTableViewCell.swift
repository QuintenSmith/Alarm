//
//  SwitchTableViewCell.swift
//  Alarm2
//
//  Created by Quinten Smith on 8/28/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

protocol switchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: switchTableViewCellDelegate?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews() 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func updateViews() {
        guard let alarm = alarm else {return}
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
