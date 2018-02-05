//
//  SuggestWordViewController.swift
//  iMessage-App MessagesExtension
//
//  Created by Ana Carolina Silva on 02/02/18.
//  Copyright © 2018 Michelle Faifer dos Santos. All rights reserved.
//

import UIKit

class SuggestWordViewController: UIViewController, UITextFieldDelegate {

    var gameWord: String?
    
    @IBOutlet weak var suggestWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestWordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charLimit = 12
        
        let startLength = textField.text?.count ?? 0
        let addLength = string.count
        let lengthReplace = range.length
        
        let setNotAllowed = NSCharacterSet.letters.inverted
        
        let newLength = startLength + addLength - lengthReplace
        
        if string.isEmpty {
            return true
        } else if let _ = string.rangeOfCharacter(from: setNotAllowed) {
            return false
        } else if newLength <= charLimit {
            return true
        } else {
            return false
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        gameWord = textField.text
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
