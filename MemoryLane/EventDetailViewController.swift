import UIKit

class EventDetailViewController: UIViewController, UIScrollViewDelegate {
    private var event: Event

    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //title = event.name
        view.backgroundColor = .white

        setupUI()
    }

    private func setupUI() {
        let eventNameLabel = UILabel()
        eventNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        eventNameLabel.text = event.name
        view.addSubview(eventNameLabel)

        let eventDateLabel = UILabel()
        eventDateLabel.font = UIFont.systemFont(ofSize: 18)
        eventDateLabel.textColor = .gray
        eventDateLabel.text = DateFormatter.localizedString(from: event.date, dateStyle: .long, timeStyle: .none)
        view.addSubview(eventDateLabel)

        // Horizontal scroll view to contain the images
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        // Array to keep track of image views
        var imageViews: [UIImageView] = []

        // Add images to the horizontal scroll view
        for imageData in event.photos {
            if let image = Event.dataToImage(imageData) {
                let eventImageView = UIImageView()
                eventImageView.contentMode = .scaleAspectFill
                eventImageView.clipsToBounds = true
                eventImageView.image = image
                scrollView.addSubview(eventImageView)
                imageViews.append(eventImageView)
            }
        }


        // Activate constraints for image views
        for (index, imageView) in imageViews.enumerated() {
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 200),
                imageView.heightAnchor.constraint(equalToConstant: 200),
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(index * 220) + 20) // Adjust spacing between images
            ])
        }

        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0 // Allow multiple lines for description
        descriptionLabel.text = event.description // Set the description text
        view.addSubview(descriptionLabel)

        // Constraints for Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20), // Place below the scroll view
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20) // Ensure a margin from the bottom
        ])

        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            eventNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            eventDateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 10),
            eventDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 50), // Adjust vertical spacing between date label and images
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            scrollView.heightAnchor.constraint(equalToConstant: 200), // Set the height of the scroll view
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor) // Occupy full width
        ])

        // Set content size of scroll view to enable scrolling
        let contentWidth = CGFloat(event.photos.count) * 220 + 20
        scrollView.contentSize = CGSize(width: contentWidth, height: 200)
    }
}

