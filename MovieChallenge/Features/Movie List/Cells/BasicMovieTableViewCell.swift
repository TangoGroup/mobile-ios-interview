//
//  BasicMovieTableViewCell.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class BasicMovieTableViewCell: UITableViewCell {
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    private let placeholderImage = UIImage(imageLiteralResourceName: "movie_placeholder")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor).isActive = true
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(ratingLabel)
        
        contentView.addSubview(labelStackView)
        labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented yet.")
    }
    
    public func configure(withMovie movie: Movie) {
        thumbnailImageView.setImage(withURL: movie.posterImageUrl, placeholderImage: placeholderImage)
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.voteAverage) / 10"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
    }
}
