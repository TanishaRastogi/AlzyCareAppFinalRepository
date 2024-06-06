import UIKit
import PhotosUI
import AVFoundation

class EventViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var eventNameTextField: UITextField!
    private var datePicker: UIDatePicker!
    private var photosCollectionView: UICollectionView!
    private var colorButtons: [UIButton] = []
    private var descriptionTextField: UITextField!
    private var selectedPhotos: [UIImage] = []
    private var selectedColor: UIColor = UIColor(red: 204.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
//        view.backgroundColor = .white
        setupUI()
        setupSaveButton()
    }
    
    private func setupUI() {
        // Event Name TextField
        eventNameTextField = UITextField()
        eventNameTextField.placeholder = "New event..."
        eventNameTextField.borderStyle = .roundedRect
        view.addSubview(eventNameTextField)
        eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            eventNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Description TextField
        descriptionTextField = UITextField()
        descriptionTextField.placeholder = "Description..."
        descriptionTextField.borderStyle = .roundedRect
        view.addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 100) // Adjusted height
        ])
        
        // Date Picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Label for Color Selection
            let colorLabel = UILabel()
            colorLabel.text = "Select Color:"
            view.addSubview(colorLabel)
            colorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                colorLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
                colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
            
            // Color Selection
            let lightColors: [UIColor] = [
                UIColor(red: 255.0/255.0, green: 182.0/255.0, blue: 193.0/255.0, alpha: 1.0), // Light Red (pink)
                UIColor(red: 255.0/255.0, green: 223.0/255.0, blue: 186.0/255.0, alpha: 1.0), // Light Orange (peach)
                UIColor(red: 144.0/255.0, green: 238.0/255.0, blue: 144.0/255.0, alpha: 1.0), // Light Green
                
                UIColor(red: 216.0/255.0, green: 191.0/255.0, blue: 216.0/255.0, alpha: 1.0), // Light Purple (thistle)
                UIColor(red: 173.0/255.0, green: 216.0/255.0, blue: 230.0/255.0, alpha: 1.0), // Light Blue (light blue)
                UIColor(red: 224.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), // Light Cyan (light cyan)
                UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 224.0/255.0, alpha: 1.0)  // Light Yellow (light yellow)
            ]
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                stackView.heightAnchor.constraint(equalToConstant: 40) // Adjusted height
            ])
            
            for color in lightColors {
                let button = UIButton()
                button.backgroundColor = color
                button.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
                button.layer.cornerRadius = 10
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.clear.cgColor
                button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true // Make the button square
                stackView.addArrangedSubview(button)
                colorButtons.append(button)
            }
            
            colorButtons.first?.layer.borderColor = UIColor.black.cgColor
        
        // Photos CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photosCollectionView.backgroundColor = .clear
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(photosCollectionView)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            photosCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Buttons StackView for Upload and Capture
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 40 // Increased spacing between buttons
        
        // Upload Photos Button
        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle("Photo Library", for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadPhotos), for: .touchUpInside)

        // Capture Photo/Video Button with Camera Symbol
        let captureButton = UIButton(type: .system)
        let cameraImage = UIImage(systemName: "camera")
        captureButton.setImage(cameraImage, for: .normal)
        captureButton.addTarget(self, action: #selector(capturePhotoOrVideo), for: .touchUpInside)

        buttonStackView.addArrangedSubview(uploadButton)
        buttonStackView.addArrangedSubview(captureButton)

        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: photosCollectionView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Constraint to keep 20 leading and trailing space for both buttons
        uploadButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor, constant: 20).isActive = true
        captureButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: -20).isActive = true

        
        
    }
    
    
    
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEvent))
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @objc private func selectColor(_ sender: UIButton) {
        for button in colorButtons {
            button.layer.borderColor = UIColor.clear.cgColor
        }
        sender.layer.borderColor = UIColor.black.cgColor
        selectedColor = sender.backgroundColor ?? .blue
    }
    
    @objc private func uploadPhotos() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func capturePhotoOrVideo() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.mediaTypes = ["public.image", "public.movie"]
        cameraPicker.allowsEditing = false
        present(cameraPicker, animated: true, completion: nil)
    }
    
    @objc private func saveEvent() {
        guard let name = eventNameTextField.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter event name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        guard let description = descriptionTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Please enter event description", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let date = datePicker.date
        
        // Convert selected photos to data
        let photosData = selectedPhotos.compactMap { image -> Data? in
            return image.pngData()
        }

        // Convert selected color to data
        let colorData = Event.colorToData(selectedColor)
        
        // Create Event instance with converted data
        let event = Event(name: name, date: date, description: description, photos: photosData, color: colorData ?? Data(), backgroundColor: colorData)
        
        // Add event to EventManager
        EventManager.shared.addEvent(event)
        
        // Navigate back to previous view controller
        navigationController?.popViewController(animated: true)
    }



    
    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        let itemProviders = results.map { $0.itemProvider }
        for itemProvider in itemProviders {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    guard let self = self else { return }
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.selectedPhotos.append(image)
                            self.photosCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            selectedPhotos.append(image)
        } else if let videoURL = info[.mediaURL] as? URL {
            // Handle video if needed
            // For now, we just add a placeholder image for videos
            if let thumbnail = thumbnailImageForVideo(url: videoURL) {
                selectedPhotos.append(thumbnail)
            }
        }
        photosCollectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func thumbnailImageForVideo(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 1, preferredTimescale: 60)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: selectedPhotos[indexPath.item])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Handle photo selection if needed
    }
}
