//
//  VideoPhotoBannerView.swift
//  RXSwift_Explore
//
//  Created by Dekai on 2020/11/24.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import CHIPageControl
import RxSwift
import RxCocoa

class VideoPhotoBannerView: UIView {
    
    let bag = DisposeBag()
    
    private lazy var pageControl: CHIPageControlJaloro = {
        let pageControl = CHIPageControlJaloro(frame: .zero)
        pageControl.radius = 1
        pageControl.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageTintColor = .white
        pageControl.padding = 5
        pageControl.elementWidth = 30
        pageControl.elementHeight = 2
        return pageControl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Frame.Screen.width, height: 375)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
//        collectionView.register(cells: [ActivityCell.self, EmptyCell.self, Cell.self])
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "profile.VideoCell")
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "profile.ImageCell")

        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(375)

        }
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.bottom).offset(-20)
            make.height.equalTo(8)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self]  in
            guard let scoll = self?.collectionView else { return }
            self?.updateTabIndex(with: scoll)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCurrentPage(_ xOffset: CGFloat) {
        //current page
        
        print("xOffset:\(xOffset)")
        guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: xOffset, y: 0)) else {
            return
        }
        pageControl.numberOfPages = collectionView.numberOfItems(inSection: indexPath.section)
        pageControl.progress = Double(indexPath.item)
    }
    
    func updateTabIndex(with scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView,
            let firstCell = collectionView.visibleCells.first,
            let indexPath = collectionView.indexPath(for: firstCell) {
            
            pageControl.numberOfPages = collectionView.numberOfItems(inSection: indexPath.section)
            pageControl.progress = Double(indexPath.item)
        }
    }
    
    fileprivate class VideoCell: UICollectionViewCell {
        
        let bag = DisposeBag()
        
        lazy var imageView = UIImageView()
        
        lazy var playButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: ""), for: .normal)
//            button.isHidden = true
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let tap = UITapGestureRecognizer()
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            
            tap.rx.event.subscribe(onNext: { (tap) in
                
            }).disposed(by: bag)
            
            contentView.addSubview(playButton)
            playButton.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(70)
            }
        }
        
        func updateCell() {
            imageView.image = UIImage(named: "background")
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    fileprivate class ImageCell: UICollectionViewCell {
        
        lazy var imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        func updateCell() {
            imageView.image = UIImage(named: "background")
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}

extension VideoPhotoBannerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profile.VideoCell", for: indexPath) as! VideoCell
            
            cell.updateCell()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profile.ImageCell", for: indexPath) as! ImageCell
            
            cell.updateCell()
            
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width / 2
        updateCurrentPage(offset)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        updateTabIndex(with: scrollView)
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if decelerate {
//            updateTabIndex(with: scrollView)
//        }
//    }
    
}
