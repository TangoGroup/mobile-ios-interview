//
//  UIImageView+Extensions.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/31/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(withURL url: URL?, placeholderImage: UIImage) {
        self.image = placeholderImage
        guard let url = url else { return }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}
