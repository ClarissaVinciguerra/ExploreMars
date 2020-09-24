//
//  AlertController.swift
//  ExploreMars
//
//  Created by Clarissa Vinciguerra on 9/23/20.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        
        // Alert from error
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        // Dismiss action
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        // Present alert
        present(alertController, animated: true)
    }
}
