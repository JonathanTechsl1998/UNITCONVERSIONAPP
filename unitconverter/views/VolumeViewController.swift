//
//  VolumeViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit
import Foundation

enum VolumeUnits: Int {
    case gallon, litre, pint, ounce, ml
}

class VolumeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet weak var mlTextField: UITextField!
    
    var volume: Volume = Volume(gallon: 0.0, litre: 0.0, pint: 0.0, ounce: 0.0, ml: 0.0)
    var historyString = [String]()
    var dataHistory: [String] = ["2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate text fields
        gallonTextField.delegate = self
        litreTextField.delegate = self
        pintTextField.delegate = self
        ounceTextField.delegate = self
        mlTextField.delegate = self

        //clear fields
        self.gallonTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.litreTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.pintTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.ounceTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        self.mlTextField.addTarget(self, action: #selector(clearTextField), for: UIControl.Event.editingDidBegin)
        
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
        switch VolumeUnits(rawValue: sender.tag)! {
        case .gallon:
            volume._gallon = doubletfValue ?? 0.0
            litreTextField.text = "\(String(format: val, volume.litre))"
            pintTextField.text = "\(String(format: val, volume.pint))"
            ounceTextField.text = "\(String(format: val, volume.ounce))"
            mlTextField.text = "\(String(format: val, volume.ml))"
            
        case .litre:
            volume._litre = doubletfValue ?? 0.0
            gallonTextField.text = "\(String(format: val, volume.gallon))"
            pintTextField.text = "\(String(format: val, volume.pint))"
            ounceTextField.text = "\(String(format: val, volume.ounce))"
            mlTextField.text = "\(String(format: val, volume.ml))"
            
        case .pint:
            volume._pint = doubletfValue ?? 0.0
            gallonTextField.text = "\(String(format: val, volume.gallon))"
            litreTextField.text = "\(String(format: val, volume.litre))"
            ounceTextField.text = "\(String(format: val, volume.ounce))"
            mlTextField.text = "\(String(format: val, volume.ml))"
            
        case .ounce:
            volume._ounce = doubletfValue ?? 0.0
            gallonTextField.text = "\(String(format: val, volume.gallon))"
            litreTextField.text = "\(String(format: val, volume.litre))"
            pintTextField.text = "\(String(format: val, volume.pint))"
            mlTextField.text = "\(String(format: val, volume.ml))"
            
        case .ml:
            volume._ml = doubletfValue ?? 0.0
            gallonTextField.text = "\(String(format: val, volume.gallon))"
            litreTextField.text = "\(String(format: val, volume.litre))"
            pintTextField.text = "\(String(format: val, volume.pint))"
            ounceTextField.text = "\(String(format: val, volume.ounce))"
            
            }
        }
        else{
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
        let arrVolume = UserDefaults.standard.object(forKey: "VolumeHistory") as? [String]
        if(arrVolume != nil){
            historyString = arrVolume!
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
        
        historyString.append(contentsOf: volume._volumeHistory)
        
        let defaults = UserDefaults.standard
        defaults.set(historyString, forKey: "VolumeHistory")
        
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
        if UserDefaults.standard.object(forKey: "VolumeHistory") != nil {
            let viewVC : HistoryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "History") as! HistoryTableViewController
            viewVC.prevView = "VolumeHistory"
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
        self.gallonTextField.text = ""
        self.litreTextField.text = ""
        self.pintTextField.text = ""
        self.mlTextField.text = ""
        self.ounceTextField.text = ""
        
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
