//
//  Diary1ViewController.swift
//  DemoAlzyCare
//
//  Created by Rishita kumari on 06/06/24.
//



import UIKit

class Diary1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Note: Codable {
        let title: String
        let note: String
    }

    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!

    var models: [Note] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            table.delegate = self
            table.dataSource = self
            title = "Notes"
            loadNotes()
        }
        
        @IBAction func didTapEdit() {
            table.isEditing = !table.isEditing
        }
        
        @IBAction func didTapNewNote() {
            guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
                return
            }
            vc.title = "New Note"
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.completion = { [weak self] noteTitle, note in
                guard let self = self else { return }
                self.navigationController?.popToRootViewController(animated: true)
                
                // Save new note
                let newNote = Note(title: noteTitle, note: note)
                self.models.insert(newNote, at: 0)
                self.saveNotes()
                
                self.label.isHidden = true
                self.table.isHidden = false
                self.table.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
        // Table
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = models[indexPath.row].title
            cell.detailTextLabel?.text = models[indexPath.row].note
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let model = models[indexPath.row]
            
            // Show note controller
            guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
                return
            }
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = "Note"
            vc.noteTitle = model.title
            vc.note = model.note
            navigationController?.pushViewController(vc, animated: true)
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Remove the item from the models array
                models.remove(at: indexPath.row)
                
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                // If there are no more items in the models array, hide the table view and show the label
                if models.isEmpty {
                    label.isHidden = false
                    table.isHidden = true
                }
                
                saveNotes()
            }
        }
        
        // MARK: - Persistence
        
        private func saveNotes() {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(models)
                UserDefaults.standard.set(data, forKey: "notes")
            } catch {
                print("Failed to save notes: \(error)")
            }
        }
        
        private func loadNotes() {
            if let data = UserDefaults.standard.data(forKey: "notes") {
                do {
                    let decoder = JSONDecoder()
                    models = try decoder.decode([Note].self, from: data)
                } catch {
                    print("Failed to load notes: \(error)")
                }
            }
        }
    }
