//
//  FeedCell.swift
//  MyFacebookFeed
//
//  Created by Tobi Omotayo on 01/01/2017.
//  Copyright © 2017 Tobi Omotayo. All rights reserved.
//

import UIKit

// Method 1: Use of Dictionary
var imageCache = NSCache<AnyObject, AnyObject>()

class FeedCell: UICollectionViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            postImageView.image = nil
            
            if let statusImageUrl = post?.statusImageUrl {
                
                if let image = imageCache.object(forKey: statusImageUrl as AnyObject) as? UIImage {
                    postImageView.image = image
                    loader.stopAnimating()
                }
                else {
                    URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        let image = UIImage(data: data!)
                        imageCache.setObject(image!, forKey: statusImageUrl as AnyObject)
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.postImageView.image = image
                            self.loader.stopAnimating()
                        })
                    }).resume()
                }
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        commentButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    func configureCell() {
        nameLabel.text = post?.name
        statusTextView.text = post?.statusText
        
        if let profileImageName = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
        }
        
        setupStatusImageViewLoader()
        
    }
    
    let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func setupStatusImageViewLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
        loader.color = .black
        postImageView.addSubview(loader)
        postImageView.addConstraintsWithFormat("H:|[v0]|", views: loader)
        postImageView.addConstraintsWithFormat("V:|[v0]", views: loader)
    }

}
