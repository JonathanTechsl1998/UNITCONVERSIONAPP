//
//  HistoryTableViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import UIKit
import Foundation

class HistoryTableViewController: UITableViewController {
    var dataHistory: [String] = [String]()
    var prevView: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(prevView)
        
    }
    
//    func historyLoadvcs(){
//        if let view = self.navigationController?.viewControllers {
//            let prevView = view[view.count - 2]
//
//            if prevView is WeightViewController {
//                self.loadData("WeightHistory")
//            } else if prevView is TempViewController {
//                self.loadData("TempHistory")
//            }  else if prevView is LengthViewController {
//                self.loadData("LengthHistory")
//            } else if prevView is SpeedViewController {
//                self.loadData("SpeedHistory")
//            } else if prevView is VolumeViewController {
//                self.loadData("VolumeHistory")
//            }
//        }
//    }

    
    func loadData(_ key:String){
        let arrData = UserDefaults.standard
        arrData.synchronize()
        dataHistory = arrData.object(forKey: key) as? [String] ?? [String]()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataHistory.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")!
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = dataHistory[indexPath.row]
        return cell
    }
    
}
