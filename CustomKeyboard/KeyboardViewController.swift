//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-19.
//

import UIKit

enum keyBtn: Int {
    case zero, one, two, three, four, five, six, seven, eight, nine, period, delete, negation
}

class KeyboardViewController: UIInputViewController {
    var keyboardView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    
    }
    
    //accessing button on keyboard
    @IBAction func btnPressed(_ sender: UIButton) {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
            switch keyBtn(rawValue: sender.tag)! {
            case .period:
                proxy.insertText(".")
            case .delete:
                while proxy.hasText {
                        let beforeText = proxy.documentContextBeforeInput
                    if beforeText!.isEmpty || beforeText!.hasSuffix(" ") {
                            break
                        }
                        proxy.deleteBackward()
                    }
            case .negation:
                proxy.insertText("-")
            default:
                proxy.insertText(sender.title(for: UIControl.State.normal)!)
            }
        }
        

}
