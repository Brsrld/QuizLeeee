//
//  UIViewController+Extension.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation
import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
    
    func alert(message: String, title: String = "", handler: ((UIAlertAction) -> Void)?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
}
