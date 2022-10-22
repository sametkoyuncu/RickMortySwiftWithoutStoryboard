//
//  RickMortyTableViewCell.swift
//  RickMortySwiftWithoutStoryboard
//
//  Created by Samet Koyuncu on 22.10.2022.
//

import UIKit
import AlamofireImage

class RickMortyTableViewCell: UITableViewCell {
    
    private let cellImage: UIImageView = UIImageView()
    private let cellTitle: UILabel = UILabel()
    private let cellDescription: UILabel = UILabel()
    
    private let noImageURL = "https://nebosan.com.tr/wp-content/uploads/2018/06/no-image.jpg"
    
    enum Identifier: String {
        case custom = "RickMortyCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(cellImage)
        addSubview(cellTitle)
        addSubview(cellDescription)
        
        cellTitle.font = .boldSystemFont(ofSize: 18)
        cellDescription.font = .italicSystemFont(ofSize: 14)
        cellTitle.numberOfLines = 0
        cellDescription.numberOfLines = 0
        
        cellImage.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.top.equalTo(contentView)
            make.left.right.equalToSuperview()
        }
        
        cellTitle.snp.makeConstraints { make in
            make.top.equalTo(cellImage.snp.bottom).offset(10)
            make.left.equalTo(cellImage).offset(10)
            make.right.equalTo(cellImage).offset(10)
        }
        
        cellDescription.snp.makeConstraints { make in
            make.top.equalTo(cellTitle.snp.bottom).offset(5)
            make.left.right.equalTo(cellTitle)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        cellTitle.text = model.name
        cellDescription.text = model.species
        cellImage.af.setImage(withURL:  URL(string: model.image ?? noImageURL)!)
    }
    
}
