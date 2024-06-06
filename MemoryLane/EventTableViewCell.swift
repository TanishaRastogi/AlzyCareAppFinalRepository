import UIKit

class EventTableViewCell: UITableViewCell {
    static let identifier = "EventTableViewCell"
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.backgroundColor = .clear
        return label
    }()
    
    private let eventDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.backgroundColor = .clear
        return label
    }()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let eventColorIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(eventNameLabel)
        contentView.addSubview(eventDateLabel)
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventColorIndicator)
        
        contentView.layer.cornerRadius = 15 // Add rounded corners to the content view
        contentView.layer.masksToBounds = true // Ensure subviews respect the corner radius
        contentView.backgroundColor = .white // Ensure background color for better visibility
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventImageView.frame = CGRect(x: 15, y: 10, width: 80, height: 58)
        eventColorIndicator.frame = CGRect(x: 15, y: 95, width: 6, height: 6) // Smaller size for the color indicator
        eventNameLabel.frame = CGRect(x: 110, y: 10, width: contentView.frame.size.width - 125, height: 20)
        eventDateLabel.frame = CGRect(x: 110, y: 35, width: contentView.frame.size.width - 125, height: 20)
    }
    
    
//    private func setupConstraints() {
//        eventImageView.translatesAutoresizingMaskIntoConstraints = false
//        eventColorIndicator.translatesAutoresizingMaskIntoConstraints = false
//        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            eventImageView.widthAnchor.constraint(equalToConstant: 80),
//            eventImageView.heightAnchor.constraint(equalToConstant: 58),
//
//            eventColorIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            eventColorIndicator.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10),
//            eventColorIndicator.widthAnchor.constraint(equalToConstant: 6),
//            eventColorIndicator.heightAnchor.constraint(equalToConstant: 6),
//
//            eventNameLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
//            eventNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            eventNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
//
//            eventDateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
//            eventDateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 5),
//            eventDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
//        ])
//    }
    func configure(with event: Event) {
        eventNameLabel.text = event.name
        eventDateLabel.text = DateFormatter.localizedString(from: event.date, dateStyle: .short, timeStyle: .none)
        
        // Convert color data to UIColor
        if let color = Event.dataToColor(event.color) {
            eventColorIndicator.backgroundColor = color
        } else {
            // Handle the case where event.color is not a valid UIColor or nil
            eventColorIndicator.backgroundColor = UIColor.white // or any default color
        }
        
        // Convert backgroundColor data to UIColor if available
        if let backgroundColorData = event.backgroundColor {
            if let backgroundColor = Event.dataToColor(backgroundColorData) {
                contentView.backgroundColor = backgroundColor
            } else {
                // Handle the case where event.backgroundColor data cannot be converted to UIColor
                contentView.backgroundColor = UIColor.white // or any default color
            }
        } else {
            // Handle the case where event.backgroundColor is nil
            contentView.backgroundColor = UIColor.white // or any default color
        }
        
        // Check if there are photos before attempting to access the first one
        if let firstImageData = event.photos.first {
            if let image = Event.dataToImage(firstImageData) {
                eventImageView.image = image
            } else {
                eventImageView.image = nil // or any default image
            }
        } else {
            eventImageView.image = nil // or any default image
        }
    }


}
