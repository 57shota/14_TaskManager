//
//  ListController.swift
//  14_TaskManager
//
//  Created by shota ito on 16/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // multile choice on/off
        listTableView.allowsMultipleSelection = false
        listTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    // count number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var listForCount: [String] = []
        
        if UserDefaults.standard.array(forKey: "list") != nil{
            listForCount = UserDefaults.standard.array(forKey: "list") as! [String]
            print("udList loaded")
        }else{
            listForCount = list
            print("udList not loaded")
        }
        
        return listForCount.count
    }
    
    // do when tableview is displayed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        if UserDefaults.standard.array(forKey: "list") != nil{
            let getList: [String] = UserDefaults.standard.array(forKey: "list") as! [String]
            cell.textLabel?.text = getList[indexPath.row]
            print("1st \(getList[indexPath.row]) ")
        }else{
            cell.textLabel?.text = list[indexPath.row]
            print("else \(list[indexPath.row]) ")
        }
        
        // add a checkmark on the previous selected cell
        if cell.textLabel?.text == UserDefaults.standard.string(forKey: "selectedCell"){
            cell.accessoryType = .checkmark
        }
        
        // no bg colour
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    // swipe remove function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            // if the selected cell does not have a mark, it is deleted.
            if cell?.accessoryType != .checkmark{
//                list.remove(at: indexPath.row)
//                titleList.remove(at: indexPath.row)
//                dateList.remove(at: indexPath.row)
                
                var getList: [String] = UserDefaults.standard.array(forKey: "list") as! [String]
                var getTitleList: [String] = UserDefaults.standard.array(forKey: "titleList") as! [String]
                var getDateList: [Date] = UserDefaults.standard.array(forKey: "dateList") as! [Date]
                getList.remove(at: indexPath.row)
                getTitleList.remove(at: indexPath.row)
                getDateList.remove(at: indexPath.row)
                
                let parent = presentingViewController as! ViewController
                parent.updateUserDefaults(getList, getTitleList, getDateList)
                
                listTableView.reloadData()
            }else{
                let alert = UIAlertController(title: "Unable to delete the selected item.", message: "Please select other item.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    // by tapping add a mark
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = .checkmark
        
        // add a mark when the list is opend next time
        UserDefaults.standard.set(cell!.textLabel!.text!, forKey: "selectedCell")
        UserDefaults.standard.synchronize()
        
        // retrieve data from UserDefault and set to display.
        let parent = presentingViewController as! ViewController
        var getTitleList: [String] = UserDefaults.standard.array(forKey: "titleList") as! [String]
        var getDateList: [Date] = UserDefaults.standard.array(forKey: "dateList") as! [Date]
        parent.titleLabel.text = getTitleList[indexPath.row]
        parent.setdate = getDateList[indexPath.row]
        parent.compareDays(parent.setdate!, 3)
        
        // save date for when the app is opend in order to retrieve 
        UserDefaults.standard.set(getTitleList[indexPath.row] as! String, forKey: "dispTitle")
        UserDefaults.standard.set(getDateList[indexPath.row] as! Date, forKey: "dispDate")
        UserDefaults.standard.synchronize()
        
        // witout reload, it becomes the multi choice at the first time.
        listTableView.reloadData()

    }
    
    // remove a mark
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .none
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
