//
//  TagsField.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import WSTagsField

class TagsField: WSTagsField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        placeholder = "Tagovi"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
