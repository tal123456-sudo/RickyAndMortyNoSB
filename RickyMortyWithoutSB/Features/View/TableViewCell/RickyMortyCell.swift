//
//  RickyMortyCell.swift
//  RickyMortyWithoutSB
//
//  Created by Muhammet  on 12.06.2022.
//

import UIKit
import AlamofireImage
class RickyMortyCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()

    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
    case custom = "talha"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 16)
        customDescription.font = .italicSystemFont(ofSize: 12)
        customImage.snp.makeConstraints { make in
            
            make.height.equalTo(140)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
           
            
        }
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.left.right.equalTo(title)
            make.bottom.equalToSuperview()
            
        }
    }
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string:  model.image ?? randomImage) ?? URL(string: randomImage)!)
    }
    

}
