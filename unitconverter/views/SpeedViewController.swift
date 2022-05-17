//
//  SpeedViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit
import Foundation

enum SpeedUnits: Int {
    case msec, kmh, mlh, nmlh
}

class SpeedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var msecTextField: UITextField!
    @IBOutlet weak var khourTextField: UITextField!
    @IBOutlet weak var mhourTextField: UITextField!
    @IBOutlet weak var nhourTextField: UITextField!
    
    var speed: Speed = Speed(msec: 0.0, kmh: 0.0, mlh: 0.0, nmlh: 0.0)
    var historyString = [String]()
    var dataHistory: [String] = ["2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate text fields
        msecTextField.delegate = self
        khourTextField.delegate = self
        mhourTextField.delegate = self
        nhourTextField.delegate = self
        
        
        //clear fields
        self.msecTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.khourTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.mhourTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.nhourTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)

        //load userDefautls
        self.loadData("Settings")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func textFieldValuechange(_ sender: UITextField){
        guard let tfValue = sender.text else { return }
        //accessing values from the textfield
        let doubletfValue = (Double(tfValue) ?? nil)
        let rawValue = Double(dataHistory.first!)
       
        //checking the pickervalue
        var val:String = ""
        if(rawValue! == 2.0){
            val = "%.2f"
        } else if(rawValue! == 3.0) {
            val = "%.3f"
        }
        else if(rawValue! == 4.0) {
            val = "%.4f"
        }
        if  (doubletfValue != 0.0) {
            
        //switching from the enum value
        switch SpeedUnits(rawValue: sender.tag)! {
        case .msec:
            speed._msec = doubletfValue ?? 0.0
            khourTextField.text = "\(String(format: val, speed.kmh))"
            mhourTextField.text = "\(String(format: val, speed.mlh))"
            nhourTextField.text = "\(String(format: val, speed.nmlh))"

            
        case .kmh:
            speed._kmh = doubletfValue ?? 0.0
            msecTextField.text = "\(String(format: val, speed.msec))"
            mhourTextField.text = "\(String(format: val, speed.mlh))"
            nhourTextField.text = "\(String(format: val, speed.nmlh))"

            
        case .mlh:
            speed._mlh = doubletfValue ?? 0.0
            khourTextField.text = "\(String(format: val, speed.kmh))"
            msecTextField.text = "\(String(format: val, speed.msec))"
            nhourTextField.text = "\(String(format: val, speed.nmlh))"


        case .nmlh:
            speed._nmlh = doubletfValue ?? 0.0
            khourTextField.text = "\(String(format: val, speed.kmh))"
            mhourTextField.text = "\(String(format: val, speed.mlh))"
            msecTextField.text = "\(String(format: val, speed.msec))"

         
            
        }
        }else{
            let alertTitle = "Error"
            let alertMsg = "not a valid input!"
            let alertConfirm = "OK"
            
            let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
            let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
            alertController.addAction(actionDone)
            self.present(alertController, animated: true, completion: nil)
            clearTextField()
            print("text fields cleared!")
        }
        
    }
    
    //save weight data to userdefaults
    @IBAction func save(_ sender: UIButton) {
        let speedTemp = UserDefaults.standard.object(forKey: "SpeedHistory") as? [String]
        if(speedTemp != nil){
            historyString = speedTemp!
        }
        print(historyString)
        
        if(historyString.count == 5){
            historyString.remove(at: 0)
            //presenting alert when values are saved
            let alertTitle = "Alert"
            let alertMsg = "only upto 5 values are allowed!"
            let alertConfirm = "OK"
            
            let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
            let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
            alertController.addAction(actionDone)
            self.present(alertController, animated: true, completion: nil)
        }
        
        historyString.append(contentsOf: speed._speedHistory)
        
        let defaults = UserDefaults.standard
        defaults.set(historyString, forKey: "SpeedHistory")
        
        //presenting alert when values are saved
        let alertTitle = "Alert"
        let alertMsg = "values are saved!"
        let alertConfirm = "OK"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
        alertController.addAction(actionDone)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //segue to history
    @IBAction func nextVC(_ sender: Any) {
        if UserDefaults.standard.object(forKey: "SpeedHistory") != nil {
            let viewVC : HistoryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "History") as! HistoryTableViewController
            viewVC.prevView = "SpeedHistory"
            self.present(viewVC, animated: true, completion: nil)
        } else {
            let alertTitle = "Alert"
            let alertMsg = "No values"
            let alertConfirm = "OK"
            
            let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
            let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
            alertController.addAction(actionDone)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    // Do any additional setup after loading the view.
    //reset text fields
    @objc func clearTextField(){
        msecTextField.text = ""
        khourTextField.text = ""
        mhourTextField.text = ""
        nhourTextField.text = ""
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChar =  ".-+1234567890"
        let allowedCharset = CharacterSet(charactersIn: allowedChar)
        let typeChar = CharacterSet(charactersIn: string)
//        guard let char = textField.text else {return true}
        let validateTf = allowedCharset.isSuperset(of: typeChar)
        
        //alertview controller for error validation
        let alertView = UIAlertController(title: "Error", message: "Only numeric values are allowed!", preferredStyle: .alert)
        alertView.view.tintColor = UIColor.red
        alertView.setValue(NSAttributedString(string: alertView.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(alertAction)
        
        if((textField.text != nil) != validateTf){
            print("error")
            self.present(alertView, animated: true, completion: nil)
        }
        return validateTf
    }
        
    
    //hide keyboard when user touches outside of the custom keypad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hide when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    func loadData(_ key:String){
        let arrWeight = UserDefaults.standard
        dataHistory = arrWeight.object(forKey: key) as? [String] ?? [String]()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
