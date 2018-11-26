//
//  ViewController.swift
//  14_TaskManager
//
//  Created by shota ito on 10/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

/*
 
 :Information
 
 - UserDefaults
 dispTitle: String   -   used to retrieve data when the app is re-opened.
 dispDate: Date   -   used to retrieve data when the app is reopened.
 list: [String]    -   used to create a label of cell on UITableView.
 titleList: [String]    -   used to manage title items for removing a cell and adding a check mark.
 dateList: [Date]   -   used to manage date items for removing a cell and adding a check mark.
 selectedCell: String   -   used to add a check mark to the set item.
 
 - Additional function
 implement the daily notification func
 set default image 
 
 
 */

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var mLabel: UIButton!
    @IBOutlet weak var wLabel: UIButton!
    @IBOutlet weak var dLabel: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    // pass the value to the compareDays func
    var setdate: Date? = nil
    
    // switch for the new set item 
    var setFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load data to display
        if UserDefaults.standard.string(forKey: "dispTitle") != nil {
            
            titleLabel.text = UserDefaults.standard.string(forKey: "dispTitle") as! String
            setdate = UserDefaults.standard.object(forKey: "dispDate") as! Date
            compareDays(setdate!, 3)
        }
        
        // load bg image to display
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            
            let filePath = dir.appendingPathComponent( "bg.png" )
            let castedimage = UIImage(contentsOfFile: filePath.path)
            
            if UIImage(contentsOfFile: filePath.path) != nil{
                bgImage.image = castedimage
            }
            
            
        }
        

    }
    
    @IBAction func monthBtn(_ sender: Any) {
        compareDays(setdate!, 1)
    }
    
    @IBAction func weekBtn(_ sender: Any) {
        compareDays(setdate!, 2)
    }
    
    @IBAction func dayBtn(_ sender: Any) {
        compareDays(setdate!, 3)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let set = self.storyboard?.instantiateViewController(withIdentifier: "AddController") as! AddController
        self.present(set, animated: true, completion: nil)
    }
    
    @IBAction func listBtn(_ sender: Any) {
        let set = self.storyboard?.instantiateViewController(withIdentifier: "ListController") as! ListController
        self.present(set, animated: true, completion: nil)
    }
    
    @IBAction func bgImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Default", style: .default, handler: { (action:UIAlertAction) in
//
//        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // save in document directory
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let pngImage = UIImage.pngData(image)
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first!
        let fileURL = documentURL.appendingPathComponent("bg.png")
        do{
            try pngImage()!.write(to: fileURL)
        }catch let e{
            print("write error", e)
        }
        
        bgImage.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func compareDays(_ date: Date, _ switchNo: Int){
        
        let now = Date()
        let months = Calendar.current.dateComponents([.month], from: now, to: date)
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: now, to: date)
        let days = Int(Calendar.current.dateComponents([.day], from: now, to: date).day!) + 1
        
        switch switchNo {
        case 1:
            leftLabel.text = "\(months.month!)"
            mLabel.setTitleColor(UIColor.init(red: 110/255, green: 160/255, blue: 1, alpha: 1), for: .normal)
            wLabel.setTitleColor(.white, for: .normal)
            dLabel.setTitleColor(.white, for: .normal)
            colourChange(months.month!)
        case 2:
            leftLabel.text = "\(weeks.weekOfYear!)"
            mLabel.setTitleColor(.white, for: .normal)
            wLabel.setTitleColor(UIColor.init(red: 110/255, green: 160/255, blue: 1, alpha: 1), for: .normal)
            dLabel.setTitleColor(.white, for: .normal)
            colourChange(weeks.weekOfYear!)
        case 3:
            leftLabel.text = "\(days)"
            mLabel.setTitleColor(.white, for: .normal)
            wLabel.setTitleColor(.white, for: .normal)
            dLabel.setTitleColor(UIColor.init(red: 110/255, green: 160/255, blue: 1, alpha: 1), for: .normal)
            colourChange(days)
        default:
            break
        }
        
    }
    
    func updateUserDefaults(_ passList: [String], _ passTitleList: [String], _ passDateList: [Date]){
        
        // update arrays to UserDefaults
        UserDefaults.standard.set(passList, forKey: "list")
        UserDefaults.standard.set(passTitleList, forKey: "titleList")
        UserDefaults.standard.set(passDateList, forKey: "dateList")
        UserDefaults.standard.synchronize()
        
        print(passList)
        print(passTitleList)
        print(passDateList)
        
    }
    
    func colourChange(_ limit: Int){
        if limit >= 1 && limit <= 3 {
            leftLabel.textColor = UIColor(red: 255/255, green: 190/255, blue: 190/255, alpha: 1)
        }else{
            leftLabel.textColor = UIColor.white
        }
    }

    
}

