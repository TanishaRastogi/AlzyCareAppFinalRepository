//
//  ViewController.swift
//  DemoAlzyCare
//
//  Created by Batch-2 on 03/06/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        SuggestedDataModel.suggestedGames.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestedCollectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as? SuggestedCollectionViewCell
        
        cell?.suggestedImageView.image = UIImage(named: SuggestedDataModel.suggestedGames[indexPath.row].gameImage)
        cell?.suggestedTextLabel.text = SuggestedDataModel.suggestedGames[indexPath.row].gameName
        
        return cell!
    }
    
    
    //   collectionViews Outlets
    
    @IBOutlet var suggestedCollectionView: UICollectionView!
    
    //    ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let suggestedNib = UINib(nibName: "Suggested", bundle: nil)
        suggestedCollectionView.register(suggestedNib, forCellWithReuseIdentifier: "SuggestedCell")
        
        suggestedCollectionView.dataSource = self
        suggestedCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 0 // No space between groups
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // No space from left and right
        
        return UICollectionViewCompositionalLayout(section: section)
    }
        
        
        
    }
    
