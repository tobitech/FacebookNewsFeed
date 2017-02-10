//
//  FeedCell.swift
//  MyFacebookFeed
//
//  Created by Tobi Omotayo on 01/01/2017.
//  Copyright © 2017 Tobi Omotayo. All rights reserved.
//

import UIKit

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
        if let statusImageName = post?.statusImageName {
            postImageView.image = UIImage(named: statusImageName)
        }
    }

}
