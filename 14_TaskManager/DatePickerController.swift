//
//  DatePickerController.swift
//  14_TaskManager
//
//  Created by shota ito on 26/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setBtn(_ sender: Any) {
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
