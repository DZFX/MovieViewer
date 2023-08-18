//
//  MainGridRouter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import UIKit

class MainGridRouter {
}

extension MainGridRouter: MainGridRouterProtocol {
    func returnToLogin(from view: MainGridViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        view.parent?.dismiss(animated: true)
    }
    
    func displayProfile(from view: MainGridViewProtocol?) {}
    
    func displayGridMenu(in view: MainGridViewProtocol?, title: String, actionTitles: [String], selectedAction: @escaping (String) -> Void) {
        guard let view = view as? UIViewController else { return }
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for actionTitle in actionTitles {
            alert.addAction(UIAlertAction(title: actionTitle,
                                          style: actionTitle == "Log out" ? .destructive : .default,
                                          handler: { action in
                selectedAction(actionTitle)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        view.present(alert, animated: true, completion: nil)
    }
}
