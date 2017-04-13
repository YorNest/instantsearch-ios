//
//  HitsCollectionWidget.swift
//  InstantSearch
//
//  Created by Guy Daher on 07/04/2017.
//
//

import Foundation

@objc public class HitsCollectionWidget: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, HitsViewDelegate, AlgoliaView {
    
    @IBInspectable public var hitsPerPage: UInt = 20
    @IBInspectable public var infiniteScrolling: Bool = true
    @IBInspectable public var remainingItemsBeforeLoading: UInt = 5
    
    @objc public weak var hitDataSource: HitCollectionViewDataSource? {
        didSet {
            dataSource = self
        }
    }
    
    @objc public weak var hitDelegate: HitCollectionViewDelegate? {
        didSet {
            delegate = self
        }
    }
    
    public var viewModel: HitsViewModelDelegate!
    
    public func scrollTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    public func reloadHits() {
        reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hit = viewModel.hitForRow(at: indexPath)
        
        return hitDataSource?.collectionView(collectionView, cellForItem: hit, at: indexPath) ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hit = viewModel.hitForRow(at: indexPath)
        
        hitDelegate?.collectionView(collectionView, didSelectItem: hit, at: indexPath)
    }
}

@objc public protocol HitCollectionViewDataSource: class {
    func collectionView(_ collectionView: UICollectionView, cellForItem hit: [String: Any], at indexPath: IndexPath) -> UICollectionViewCell
}

@objc public protocol HitCollectionViewDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItem hit: [String: Any], at indexPath: IndexPath)
}
