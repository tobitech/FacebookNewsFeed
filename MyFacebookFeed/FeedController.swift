//
//  ViewController.swift
//  MyFacebookFeed
//
//  Created by Tobi Omotayo on 01/01/2017.
//  Copyright © 2017 Tobi Omotayo. All rights reserved.
//

import UIKit

let cellId = "cellId"

let posts = Posts()

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDataPath")
        URLCache.shared = cache
       
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.numberOfPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath]
        feedCell.feedController = self
        feedCell.configureCell()
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 8 + 8 + 205 + 8 + 21 + 8 + 1 + 8 + 24 + 8
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 16)
            
        }
        
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    var postImageView: UIImageView?
    let navBarCover = UIView()
    let tabBarCover = UIView()
    
    func animateImageView(postImageView: UIImageView) {
        
        self.postImageView = postImageView
        
        if let startingFrame = postImageView.superview?.convert(postImageView.frame, to: nil) {
            
            postImageView.alpha = 0
            
            blackBackgroundView.frame = self.view.bounds
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCover.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCover.backgroundColor = .black
            navBarCover.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCover)
                
                tabBarCover.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCover.backgroundColor = .black
                tabBarCover.alpha = 0
                keyWindow.addSubview(tabBarCover)
            }
            
            zoomImageView.backgroundColor = .red
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = postImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            zoomImageView.frame = startingFrame
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedController.zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height);
                self.blackBackgroundView.alpha = 1
                self.navBarCover.alpha = 1
                self.tabBarCover.alpha = 1
            }, completion: nil)
        }
        
    }
    
    func zoomOut() {
        
        if let startingFrame = postImageView!.superview?.convert(postImageView!.frame, to: nil) {
            UIView.animate(withDuration: 0.75, animations: { 
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCover.alpha = 0
                self.tabBarCover.alpha = 0
            }, completion: { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCover.removeFromSuperview()
                self.tabBarCover.removeFromSuperview()
                self.postImageView?.alpha = 1
            })
        }
        
    }

}

