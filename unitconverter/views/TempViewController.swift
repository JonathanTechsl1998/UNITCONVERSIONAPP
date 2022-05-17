//
//  TempViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit
import Foundation

enum TempUnits: Int {
    case celcius, fahrenheit, kelvin
}

class TempViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var celciusTextField: UITextField!
    @IBOutlet weak var fahTextField: UITextField!
    @IBOutlet weak var kelTextField: UITextField!
    
    var temp: Temp = Temp(celcius: 0.0, fahrenheit: 0.0, kelvin: 0.0)
    var historyString = [String]()
    var dataHistory: [String] = ["2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate text fields
        celciusTextField.delegate = self
        fahTextField.delegate = self
        kelTextField.delegate = self
        
        
        //clear fields
        self.celciusTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.fahTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.kelTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        
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
        
        if (doubletfValue != 0.0) {
            
        //switching from the enum value
        switch TempUnits(rawValue: sender.tag)! {
        case .celcius:
            temp._celcius = doubletfValue ?? 0.0
            fahTextField.text = "\(String(format: val, temp.fahrenheit))"
            kelTextField.text = "\(String(format: val, temp.kelvin))"
            
        case .fahrenheit:
            temp._fahrenheit = doubletfValue ?? 0.0
            celciusTextField.text = "\(String(format: val, temp.celcius))"
            kelTextField.text = "\(String(format: val, temp.kelvin))"
            
        case .kelvin:
            temp._kelvin = doubletfValue ?? 0.0
            celciusTextField.text = "\(String(format: val, temp.celcius))"
            fahTextField.text = "\(String(format: val, temp.fahrenheit))"

            
            
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
        let arrTemp = UserDefaults.standard.object(forKey: "TempHistory") as? [String]
        if(arrTemp != nil){
            historyString = arrTemp!
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
        
        historyString.append(contentsOf: temp._tempHistory)
        
        let defaults = UserDefaults.standard
        defaults.set(historyString, forKey: "TempHistory")
        
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
        if UserDefaults.standard.object(forKey: "TempHistory") != nil {
            let viewVC : HistoryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "History") as! HistoryTableViewController
            viewVC.prevView = "TempHistory"
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
        self.celciusTextField.text = ""
        self.fahTextField.text = ""
        self.kelTextField.text = ""
        
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
