//
//  UIViewController+Extension.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

extension UIViewController {
    func showMyErrorAlert(_ myError: MyError, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Greška",
                                                message: myError.getMessage(),
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            completion?()
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
