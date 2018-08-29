//
//  AlarmListTableViewController.swift
//  Alarm2
//
//  Created by Quinten Smith on 8/28/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, switchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm) 
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as? SwitchTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.alarm = alarm
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            let alarm = AlarmController.shared.alarms[indexPath.row]
            destinationVC?.alarm = alarm
    }
    
    }

}
