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

    func showAlertControllerWithTextField(title: String, message: String?, placeholder: String?, completion: @escaping ((String?) -> Void)) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        setAlertActionsFor(alertController, completion: completion)
        present(alertController, animated: true)
    }

    private func setAlertActionsFor(_ alertController: UIAlertController, completion: @escaping ((String?) -> Void)) {
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            let email = alertController.textFields?.first?.text
            completion(email)
        }
        let cancelAction = UIAlertAction(title: "Odustani", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    }
}
