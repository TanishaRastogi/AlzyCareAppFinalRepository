//
//  ViewController.swift
//  DemoAlzyCare
//
//  Created by Batch-2 on 03/06/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource{
   
    
    //   collectionViews Outlets
    
    @IBOutlet var suggestedCollectionView: UICollectionView!
    
    //    ViewDidLoad
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            print("ViewDidLoad called")

            // Check if the suggestedCollectionView outlet is connected
            guard let suggestedCollectionView = suggestedCollectionView else {
                print("Error: suggestedCollectionView is not connected")
                return
            }
            
            let suggestedNib = UINib(nibName: "Suggested", bundle: nil)
            suggestedCollectionView.register(suggestedNib, forCellWithReuseIdentifier: "SuggestedCell")
            
            suggestedCollectionView.dataSource = self
            suggestedCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
            
            print("View setup completed")
        }

        // DataSource methods
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("Number of items in section: \(SuggestedDataModel.suggestedGames.count)")
            return SuggestedDataModel.suggestedGames.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = suggestedCollectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as? SuggestedCollectionViewCell else {
                fatalError("Unable to dequeue SuggestedCollectionViewCell")
            }
            
            let game = SuggestedDataModel.suggestedGames[indexPath.row]
            cell.suggestedImageView.image = UIImage(named: game.gameImage)
            cell.suggestedTextLabel.text = game.gameName

            print("Configured cell at index: \(indexPath.row) with game: \(game.gameName)")

            return cell
        }

        // Layout generation
        func generateLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 0 // No space between groups
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // No space from left and right
            
            print("Layout generated")
            
            return UICollectionViewCompositionalLayout(section: section)
        }
    }
