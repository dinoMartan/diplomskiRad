 //
//  EditProjectView.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import SnapKit
import UIKit

class EditProjectView: UIView {
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Naziv projekta"
        return textField
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()

    let haveTagsField: TagsField = {
        let tagsField = TagsField()
        return tagsField
    }()

    let needTagsField: TagsField = {
        let tagsField = TagsField()
        return tagsField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spremi", for: .normal)
        button.backgroundColor = .tertiarySystemBackground
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()

    var saveButtonAction: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit \(self)")
    }
}

extension EditProjectView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemBackground
    }

    private func addSubviews() {
        addSubview(titleTextField)
        addSubview(descriptionTextView)
        addSubview(haveTagsField)
        addSubview(needTagsField)
        addSubview(saveButton)
    }

    private func setupCoinstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        haveTagsField.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        needTagsField.snp.makeConstraints { make in
            make.top.equalTo(haveTagsField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(needTagsField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension EditProjectView {
    @objc
    private func didTapSaveButton() {
        saveButtonAction?()
    }
}
