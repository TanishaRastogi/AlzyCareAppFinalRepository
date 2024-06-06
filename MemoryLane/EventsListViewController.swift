import UIKit

class EventsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var emptyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MemoryLane"
        view.backgroundColor = .white
        
        setupTableView()
        setupEmptyLabel()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortEvents))
        
        navigationItem.rightBarButtonItems = [addButton, sortButton]
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.action = #selector(editButtonTapped)
        
        updateEmptyState()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.tabBarItem.title = "MemoryLane"
        self.tabBarItem.image = UIImage(systemName: "brain")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateEmptyState()
    }
    
    @objc private func editButtonTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }

    @objc private func sortEvents() {
        EventManager.shared.sortEventsByDate()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.separatorStyle = .none
        // Add a header view to the table view to act as a spacer
        let headerView = UIView(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 20)) // Adjust the height as needed
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupEmptyLabel() {
        emptyLabel = UILabel()
        emptyLabel.text = "No memories yet. Tap '+' to add a new memory."
        emptyLabel.textColor = .gray
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        view.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func addEvent() {
        let eventVC = EventViewController()
        navigationController?.pushViewController(eventVC, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        let event = EventManager.shared.getEvents()[indexPath.section]
        cell.configure(with: event)
        
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        
        // Convert color data to UIColor
        if let backgroundColorData = event.backgroundColor,
           let backgroundColor = Event.dataToColor(backgroundColorData) {
            cell.contentView.backgroundColor = backgroundColor
        } else {
            // Handle the case where event.backgroundColor is not a valid UIColor
            cell.contentView.backgroundColor = UIColor.white // or any default color
        }

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImageView.tintColor = .gray
        cell.contentView.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        return cell
    }
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return EventManager.shared.getEvents().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let event = EventManager.shared.getEvents()[indexPath.section]
        let detailVC = EventDetailViewController(event: event)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EventManager.shared.deleteEvent(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
            updateEmptyState()
        }
    }
    
    private func updateEmptyState() {
        let eventsCount = EventManager.shared.getEvents().count
        let shouldHideButtons = eventsCount == 0
        navigationItem.rightBarButtonItems?.forEach { item in
            if item.title == "Sort" {
                item.isEnabled = !shouldHideButtons
                item.tintColor = shouldHideButtons ? .clear : nil
            }
        }
        navigationItem.leftBarButtonItem?.isEnabled = !shouldHideButtons
        navigationItem.leftBarButtonItem?.tintColor = shouldHideButtons ? .clear : nil
        emptyLabel.isHidden = eventsCount > 0
    }
}
