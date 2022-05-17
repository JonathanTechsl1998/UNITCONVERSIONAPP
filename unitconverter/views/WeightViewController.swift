//
//  WeightViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit
import Foundation

enum WeightUnits: Int {
    case kg, grams, ounces, pounds, stone
}


class WeightViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var kgTextField: UITextField!
    @IBOutlet weak var gramsTextField: UITextField!
    @IBOutlet weak var ouncesTextField: UITextField!
    @IBOutlet weak var poundsTextField: UITextField!
    @IBOutlet weak var stoneTextField: UITextField!
    
    var weight: Weight = Weight(kg: 0.0, grams: 0.0, ounces: 0.0, pounds: 0.0, stone: 0.0)
    var historyString = [String]()
    var dataHistory = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate text fields
        kgTextField.delegate = self
        gramsTextField.delegate = self
        ouncesTextField.delegate = self
        poundsTextField.delegate = self
        stoneTextField.delegate = self
        
        
        //clear fields
        self.kgTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.gramsTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.ouncesTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.poundsTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.stoneTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        
        //load userDefautls
        self.loadData("Settings")

        
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
        }
        else if(rawValue! == 3.0) {
            val = "%.3f"
        }
        else if(rawValue! == 4.0) {
            val = "%.4f"
        }
        
        if (doubletfValue != 0.0) {
            
        //switching from the enum value
        switch WeightUnits(rawValue: sender.tag)! {
        case .kg:
            weight._kg = doubletfValue ?? 0.0
            gramsTextField.text = "\(String(format: val, weight.grams))"
            ouncesTextField.text = "\(String(format: val, weight.ounces))"
            poundsTextField.text = "\(String(format: val, weight.pounds))"
            stoneTextField.text = "\(String(format: val, weight.stone))"
            print(val)
            
        case .grams:
            weight._grams = doubletfValue ?? 0.0
            kgTextField.text = "\(String(format: val, weight.kg))"
            ouncesTextField.text = "\(String(format: val, weight.ounces))"
            poundsTextField.text = "\(String(format: val, weight.pounds))"
            stoneTextField.text = "\(String(format: val, weight.stone))"
            
        case .ounces:
            weight._ounces = doubletfValue ?? 0.0
            kgTextField.text = "\(String(format: val, weight.kg))"
            gramsTextField.text = "\(String(format: val, weight.grams))"
            poundsTextField.text = "\(String(format: val, weight.pounds))"
            stoneTextField.text = "\(String(format: val, weight.stone))"
            
        case .pounds:
            weight._pounds = doubletfValue ?? 0.0
            kgTextField.text = "\(String(format: val, weight.kg))"
            gramsTextField.text = "\(String(format: val, weight.grams))"
            ouncesTextField.text = "\(String(format: val, weight.ounces))"
            stoneTextField.text = "\(String(format: val, weight.stone))"
            
        case .stone:
            weight._stone = doubletfValue ?? 0.0
            kgTextField.text = "\(String(format: val, weight.kg))"
            gramsTextField.text = "\(String(format: val, weight.grams))"
            ouncesTextField.text = "\(String(format: val, weight.ounces))"
            poundsTextField.text = "\(String(format: val, weight.pounds))"
            
            
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
        let arrWeight = UserDefaults.standard.object(forKey: "WeightHistory") as? [String]
        if(arrWeight != nil){
            historyString = arrWeight!
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
        
        historyString.append(contentsOf: weight._weightHistory)
        
        let defaults = UserDefaults.standard
        defaults.set(historyString, forKey: "WeightHistory")
        
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
        if UserDefaults.standard.object(forKey: "WeightHistory") != nil {
            let viewVC : HistoryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "History") as! HistoryTableViewController
            viewVC.prevView = "WeightHistory"
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
        self.kgTextField.text = ""
        self.gramsTextField.text = ""
        self.ouncesTextField.text = ""
        self.poundsTextField.text = ""
        self.stoneTextField.text = ""
        
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
