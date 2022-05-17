//
//  HomeViewController.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-02-17.
//

import UIKit

class HomeViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var inforBtn: UIButton!
    @IBOutlet weak var getstartBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func infoButtonpressed(_ sender: Any) {
        let alertTitle = "About"
        let alertMsg = "The app shall convert weights, temperature, volumes, liquid volumes, distance and speed. It also allows the user to save the last five conversion for each unit category."
        let alertConfirm = "OK"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: alertConfirm, style: .default, handler: nil)
        alertController.addAction(actionDone)
        self.present(alertController, animated: true, completion: nil)
        
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
