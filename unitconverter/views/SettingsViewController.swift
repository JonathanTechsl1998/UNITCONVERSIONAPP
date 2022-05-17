//
//  SettingsViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-18.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String] = [String]()
    var precisionData: String = "2"
    var historyString: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerData = ["2","3","4"]
        // Do any additional setup after loading the view.
    }
    
    //picker view controller data source and properties
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return pickerData.count
        }else{
            return pickerData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView.tag == 1{
                return pickerData[row]
            }else{
                return pickerData[row]
            }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            precisionData = pickerData[row]
        } else {
            precisionData = pickerData[row]
        }
    }
    
    func loadDefaultsData(_ key :String) {
        let defaults = UserDefaults.standard
        historyString = defaults.object(forKey: key) as? [String] ?? [String]()
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        let value = precisionData
        
        let defaults = UserDefaults.standard
        let rawValue = value
        
        self.historyString.removeAll()
        self.historyString.append(rawValue)
        defaults.set(historyString, forKey: "Settings")
        
        
        //presenting alert when values are saved
        let alertTitle = "Alert"
        let alertMsg = "Settings saved!"
        let alertConfirm = "OK"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
        alertController.addAction(actionDone)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clear(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "WeightHistory")
        UserDefaults.standard.removeObject(forKey: "TempHistory")
        UserDefaults.standard.removeObject(forKey: "LengthHistory")
        UserDefaults.standard.removeObject(forKey: "SpeedHistory")
        UserDefaults.standard.removeObject(forKey: "VolumeHistory")
        UserDefaults.standard.synchronize()
        
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
