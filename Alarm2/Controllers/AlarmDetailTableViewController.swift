//
//  AlarmDetailTableViewController.swift
//  Alarm2
//
//  Created by Quinten Smith on 8/28/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var alarmEnabledButton: UIButton!
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews() 
        }
    }
    
    var alarmIsOn: Bool = true
    
    func setUpAlarmButton(){
        
        switch alarmIsOn {
        case true:
            alarmEnabledButton.backgroundColor = UIColor.green
            alarmEnabledButton.setTitle("ON", for: .normal)
        case false:
            alarmEnabledButton.backgroundColor = UIColor.red
            alarmEnabledButton.setTitle("Off", for: .normal)
        }
    }

    
    func updateViews() {
        guard let alarm = alarm else {return}
        alarmIsOn = alarm.enabled
        alarmDatePicker.date = alarm.fireDate
        nameTextField.text = alarm.name
        setUpAlarmButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else {return}
        AlarmController.shared.toggleEnabled(for: alarm)
        setUpAlarmButton()
        alarmIsOn = !alarmIsOn
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {return}
        guard name != "" else {return}
        
        if let alarm = alarm{
            AlarmController.shared.update(alarm: alarm, fireDate: alarmDatePicker.date, name: name, enabled: true) 
        } else{
            AlarmController.shared.addAlarm(fireDate: alarmDatePicker.date, name: name, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   

}
