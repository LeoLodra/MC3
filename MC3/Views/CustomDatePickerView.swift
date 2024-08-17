//
//  CustomDatePickerView.swift
//  MC3
//
//  Created by Leonardo Marhan on 17/08/24.
//

import UIKit

class CustomDatePickerView: UIView {
    
    let containerView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let lmpInput: UIDatePicker = {
        let input = UIDatePicker()
        input.sizeToFit()
        input.datePickerMode = .date
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addArrangedSubview(calendarIcon)
        containerView.addArrangedSubview(lmpInput)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 44),
            
            calendarIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            calendarIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            calendarIcon.widthAnchor.constraint(equalToConstant: 24),
            calendarIcon.heightAnchor.constraint(equalToConstant: 24),
            
            lmpInput.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 10),
            lmpInput.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}

