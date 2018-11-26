//
//  AddController.swift
//  14_TaskManager
//
//  Created by shota ito on 13/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import UIKit

class AddController: UIViewController {

    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var picker: UIDatePicker!
    
    var date: Date? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addDateBtn(_ sender: Any) {
        
        let parent = presentingViewController as! ViewController
        // append task for the display of cell
        // append task for the main display
        if inputTitle.text != ""{
            
            // save data to list
            let formattedDate = dateFormat(picker.date)
            let listLabel = "\(inputTitle.text!) - \(formattedDate)"
            
            if UserDefaults.standard.array(forKey: "list") != nil{
                
                // from the second time after UserDefaults is created
                var getList: [String] = UserDefaults.standard.array(forKey: "list") as! [String]
                var getTitleList: [String] = UserDefaults.standard.array(forKey: "titleList") as! [String]
                var getDateList: [Date] = UserDefaults.standard.array(forKey: "dateList") as! [Date]
                getList.append(listLabel)
                getTitleList.append("\(inputTitle.text!)")
                getDateList.append(picker.date)
                
                parent.updateUserDefaults(getList, getTitleList, getDateList)
                
            }else{
                
                // for the first time before UserDefaults is created
                list.append(listLabel)
                titleList.append("\(inputTitle.text!)")
                dateList.append(picker.date)
                
                parent.updateUserDefaults(list, titleList, dateList)
                
            }
            
            //change leftLabel text
            let alert = UIAlertController(title: "New Item", message: "Would you like to set on the main display?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { (UIAlertAction) in
                parent.setdate = self.picker.date
                parent.compareDays(self.picker.date, 3)
                parent.titleLabel.text = self.inputTitle.text!
                UserDefaults.standard.set(listLabel, forKey: "selectedCell")
                UserDefaults.standard.set(self.inputTitle.text!, forKey: "dispTitle")
                UserDefaults.standard.set(self.picker.date, forKey: "dispDate")
                UserDefaults.standard.synchronize()
                
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Later", style: .cancel, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true)
            
        }else{
            
            let alert = UIAlertController(title: "No Title", message: "Please input a title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)

        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func dateFormat(_ date: Date) -> String{
        
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let sDate = format.string(from: date)
        
        return sDate
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func dailyNoti(_ sender: UISwitch) {
        
        if sender.isOn {
            let datePick = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerController") as! DatePickerController
            self.present(datePick, animated: true, completion: nil)
            
        }else{
            
        }
        
    }
    
    
    
}
