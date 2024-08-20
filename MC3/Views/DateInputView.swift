//
//  DateInputView.swift
//  MC3
//
//  Created by Leonardo Marhan on 20/08/24.
//

import UIKit

class DateInputView: UIView {
    
    let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateInput: UIDatePicker = {
        let input = UIDatePicker()
        input.sizeToFit()
        input.preferredDatePickerStyle = .compact
        input.datePickerMode = .date
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(calendarIcon)
        addSubview(dateInput)
        
        NSLayoutConstraint.activate([
            calendarIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            calendarIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            calendarIcon.widthAnchor.constraint(equalToConstant: 24),
            calendarIcon.heightAnchor.constraint(equalToConstant: 24),
            
            dateInput.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 10),
            dateInput.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateInput.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    var selectedDate: Date {
        return dateInput.date
    }
}
