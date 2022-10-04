//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Lộc Xuân  on 28/09/2022.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func ProfileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func ProfileHeaderDidTapFollowerButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func ProfileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func ProfileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    let followerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follower", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground

        return button
    }()
    
    let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground

        return button
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Xalo"
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is first account"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        postsButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        followerButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(profileImage)
        addSubview(postsButton)
        addSubview(followerButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profileImageSize = width / 4
        
        profileImage.frame = CGRect(
            x: 5,
            y: 5,
            width: profileImageSize,
            height: profileImageSize
        ).integral
        
        profileImage.layer.cornerRadius = profileImage.width / 2
        
        let buttonHeight = profileImageSize / 2
        let countButtonWidth = (width - 10 - profileImage.width) / 3
        
        postsButton.frame = CGRect(
            x: profileImage.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followerButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followerButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editProfileButton.frame = CGRect(
            x: profileImage.right,
            y: postsButton.bottom,
            width: width - 10 - profileImage.width,
            height: buttonHeight
        )
        
        nameLabel.frame = CGRect(
            x: 5,
            y: profileImage.bottom + 5,
            width: width,
            height: buttonHeight
        )
        
        bioLabel.frame = CGRect(
            x: 5,
            y: nameLabel.bottom + 5,
            width: width,
            height: buttonHeight
        )
    }
    
    // MARK: -Action
    
    @objc private func didTapPostButton(){
        delegate?.ProfileHeaderDidTapPostButton(self)
    }
    
    @objc private func didTapFollowerButton(){
        delegate?.ProfileHeaderDidTapFollowerButton(self)
    }
    
    @objc private func didTapFollowingButton(){
        delegate?.ProfileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton(){
        delegate?.ProfileHeaderDidTapEditProfileButton(self)
    }
}
