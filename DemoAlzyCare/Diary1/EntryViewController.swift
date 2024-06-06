//
//  EntryViewController.swift
//  DemoAlzyCare
//
//  Created by Rishita kumari on 06/06/24.
//


import UIKit

class EntryViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!

    public var completion: ((String, String) -> Void)?

        override func viewDidLoad() {
            super.viewDidLoad()
            titleField.becomeFirstResponder()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                view.addGestureRecognizer(tapGesture)
            
            view.isUserInteractionEnabled = true
        }

        @objc func didTapSave() {
            if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
                completion?(text, noteField.text)
            }
            
            // Dismiss the view controller after saving the note
            navigationController?.popViewController(animated: true)
        }
        
        @objc func handleTap() {
            view.endEditing(true)
        }
    }
