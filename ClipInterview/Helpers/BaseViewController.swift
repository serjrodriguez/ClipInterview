//
//  BaseViewController.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    internal func presentAlertWithTitle(
        _ title: String?,
        message msg: String? = nil,
        firstActionTitle: String? = nil,
        firstAction firstActionHandler: @escaping ((UIAlertAction) -> Void) = { _ in },
        firstActionStyle firstStyle: UIAlertAction.Style = .default,
        secondActionTitle: String? = nil,
        secondActionStyle secondStyle: UIAlertAction.Style = .cancel,
        secondAction secondActionHandler: @escaping ((UIAlertAction) -> Void) = { _ in }
    ) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let firstActionTitle = firstActionTitle {
            let firstAction = UIAlertAction(title: firstActionTitle,
                                            style: firstStyle,
                                            handler: firstActionHandler)
            alertController.addAction(firstAction)
            alertController.preferredAction = firstAction
        }
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle,
                                             style: secondStyle,
                                             handler: secondActionHandler)
            alertController.addAction(secondAction)
        }
        
        self.present(alertController, animated: true)
    }
}
