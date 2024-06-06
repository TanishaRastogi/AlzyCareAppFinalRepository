import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let profileImageView = UIImageView()
    
    let profileSections: [[String]] = [
        ["Phone Number", "Date of birth", "Gender"],
        ["Edit Profile", "Change Password"],
        [ "Your Assessment Score", "Log Out"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Register a basic UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Setup constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Set up the table view header with profile image and labels
        setupTableViewHeader()
    }
    
    func setupTableViewHeader() {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 250) // Adjusted height to include bottom padding
        headerView.backgroundColor = UIColor(red: 204.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        headerView.layer.cornerRadius = 20
        headerView.layer.masksToBounds = true
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.circle") // Use your profile image here
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50 // Make it circular
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.systemGray.cgColor
        
        // Add Camera Button
        let cameraButton = UIButton(type: .system)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.backgroundColor = UIColor(red: 204.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        cameraButton.layer.cornerRadius = 12
        cameraButton.addTarget(self, action: #selector(choosePhotoButtonTapped(_:)), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "AlzyCare"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "name" // Replace with actual name
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "name@example.com" // Replace with actual email
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textAlignment = .center
        emailLabel.textColor = .black
        
        let bottomPaddingView = UIView()
        bottomPaddingView.translatesAutoresizingMaskIntoConstraints = false
        bottomPaddingView.backgroundColor = .clear // Transparent view to add space
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(profileImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(emailLabel)
        headerView.addSubview(bottomPaddingView)
        headerView.addSubview(cameraButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            cameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4), // Adjusted bottom constraint
            cameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4), // Adjusted trailing constraint
            cameraButton.widthAnchor.constraint(equalToConstant: 30),
            cameraButton.heightAnchor.constraint(equalToConstant: 30),
            
            bottomPaddingView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            bottomPaddingView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            bottomPaddingView.widthAnchor.constraint(equalTo: headerView.widthAnchor),
            bottomPaddingView.heightAnchor.constraint(equalToConstant: 20) // Adding 20 points of padding at the bottom
        ])
        
        tableView.tableHeaderView = headerView
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let choosePhotoAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(choosePhotoAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(takePhotoAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("Image picked successfully")
            profileImageView.image = image
        } else {
            print("No image picked")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = profileSections[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell selection
        let selectedOption = profileSections[indexPath.section][indexPath.row]
        print("Selected option: \(selectedOption)")
        // Perform actions based on the selected option
    }
}
