//
//  LengthViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit
import Foundation

enum LengthUnits: Int {
    case m, km, mile, cm, mm, yard, inch
}

class LengthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var meterTextField: UITextField!
    @IBOutlet weak var kmTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var cmTextField: UITextField!
    @IBOutlet weak var mmTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    var length: Length = Length(m: 0.0, km: 0.0, mile: 0.0, cm: 0.0, mm: 0.0, yard: 0.0, inch: 0.0)
    var historyString = [String]()
    var dataHistory: [String] = ["2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //delegate text fields
        meterTextField.delegate = self
        kmTextField.delegate = self
        mileTextField.delegate = self
        cmTextField.delegate = self
        mmTextField.delegate = self
        yardTextField.delegate = self
        inchTextField.delegate = self
        
        
        //clear fields
        self.meterTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.kmTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.mileTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.cmTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.mmTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.yardTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.inchTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        
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
        switch LengthUnits(rawValue: sender.tag)! {
        case .m:
            length._m = doubletfValue ?? 0.0
            kmTextField.text = "\(String(format: val, length.km))"
            mileTextField.text = "\(String(format: val, length.mile))"
            cmTextField.text = "\(String(format: val, length.cm))"
            mmTextField.text = "\(String(format: val, length.mm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            inchTextField.text = "\(String(format: val, length.inch))"
            
        case .km:
            length._km = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            mileTextField.text = "\(String(format: val, length.mile))"
            cmTextField.text = "\(String(format: val, length.cm))"
            mmTextField.text = "\(String(format: val, length.mm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            inchTextField.text = "\(String(format: val, length.inch))"
            
        case .mile:
            length._mile = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            kmTextField.text = "\(String(format: val, length.km))"
            cmTextField.text = "\(String(format: val, length.cm))"
            mmTextField.text = "\(String(format: val, length.mm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            inchTextField.text = "\(String(format: val, length.inch))"

        case .cm:
            length._cm = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            kmTextField.text = "\(String(format: val, length.km))"
            mileTextField.text = "\(String(format: val, length.mile))"
            mmTextField.text = "\(String(format: val, length.mm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            inchTextField.text = "\(String(format: val, length.inch))"
            
        case .mm:
            length._mm = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            kmTextField.text = "\(String(format: val, length.km))"
            mileTextField.text = "\(String(format: val, length.mile))"
            cmTextField.text = "\(String(format: val, length.cm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            inchTextField.text = "\(String(format: val, length.inch))"
            
        case .yard:
            length._yard = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            kmTextField.text = "\(String(format: val, length.km))"
            mileTextField.text = "\(String(format: val, length.mile))"
            cmTextField.text = "\(String(format: val, length.cm))"
            mmTextField.text = "\(String(format: val, length.mm))"
            inchTextField.text = "\(String(format: val, length.inch))"
            
        case .inch:
            length._inch = doubletfValue ?? 0.0
            meterTextField.text = "\(String(format: val, length.m))"
            kmTextField.text = "\(String(format: val, length.km))"
            mileTextField.text = "\(String(format: val, length.mile))"
            cmTextField.text = "\(String(format: val, length.cm))"
            mmTextField.text = "\(String(format: val, length.mm))"
            yardTextField.text = "\(String(format: val, length.yard))"
            
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
        let lenTemp = UserDefaults.standard.object(forKey: "LengthHistory") as? [String]
        if(lenTemp != nil){
            historyString = lenTemp!
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
        
        historyString.append(contentsOf: length._lengthHistory)
        
        let defaults = UserDefaults.standard
        defaults.set(historyString, forKey: "LengthHistory")
        
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
        if UserDefaults.standard.object(forKey: "LengthHistory") != nil {
            let viewVC : HistoryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "History") as! HistoryTableViewController
            viewVC.prevView = "LengthHistory"
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
        self.meterTextField.text = ""
        self.kmTextField.text = ""
        self.mileTextField.text = ""
        self.cmTextField.text = ""
        self.mmTextField.text = ""
        self.yardTextField.text = ""
        self.inchTextField.text = ""
        
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
