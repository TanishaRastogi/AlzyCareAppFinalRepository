//
//  OnboardingContentViewController.swift
//  OnboardingScreens
//
//  Created by Tanisha Rastogi on 05/06/24.
//

import UIKit

class OnboardingContentViewController: UIViewController {
    var titleText: String?
    var descriptionText: String?
    var imageName: String?
    var pageIndex: Int = 0
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let actionButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
        applyAnimations()
    }
    
    private func setupSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 121.0/255.0, green: 87.0/255.0, blue: 169.0/255.0, alpha: 1.0) // Dark purple shade
        titleLabel.attributedText = attributedTextForTitle(titleText ?? "")
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor(named: "LightPurple") // Lighter shade
        descriptionLabel.text = descriptionText
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName ?? "")
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = UIColor(red: 121.0/255.0, green: 87.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        actionButton.layer.cornerRadius = 8
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        if pageIndex < 3 {
            // Skip button for all screens except the last one
            actionButton.setTitle("Skip", for: .normal)
        } else {
            // Get Started button for the last screen
            actionButton.setTitle("Get Started", for: .normal)
        }
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        view.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), // Adjusted top anchor
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60), // Adjusted top anchor
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40), // Adjusted top anchor
            actionButton.widthAnchor.constraint(equalToConstant: 160), // Adjust button width as needed
            actionButton.heightAnchor.constraint(equalToConstant: 40) // Adjust button height as needed
        ])
    }
    
    @objc private func actionButtonTapped() {
        print("Action button tapped") // Debugging print statement
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            print("Error: Unable to instantiate ViewController") // Debugging print statement
            return
        }
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        } else {
            print("Error: No window available") // Debugging print statement
        }
    }
    
    private func applyAnimations() {
        imageView.alpha = 0.0
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.alpha = 1.0
            self.imageView.transform = CGAffineTransform.identity
        })
    }
    
    private func attributedTextForTitle(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor(red: 121.0/255.0, green: 87.0/255.0, blue: 169.0/255.0, alpha: 1.0) // Default to purple if "DarkPurple" is not defined
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
