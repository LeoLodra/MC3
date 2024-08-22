//
//  HeightInputView.swift
//  MC3
//
//  Created by Leonardo Marhan on 17/08/24.
//

import UIKit

class HeightInputView: UIView {
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Could you tell me your height?"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightInput: UITextField = {
        let input = UITextField()
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 10
        input.layer.borderColor = UIColor.systemGray4.cgColor
        input.placeholder = "0"
        input.borderStyle = .roundedRect
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    private let cmLabel: UILabel = {
        let label = UILabel()
        label.text = "Cm"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(heightLabel)
        addSubview(heightInput)
        addSubview(cmLabel)
        
        NSLayoutConstraint.activate([
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            heightInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            heightInput.topAnchor.constraint(equalTo: topAnchor),
            heightInput.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightInput.centerYAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 25),
            heightInput.trailingAnchor.constraint(equalTo: cmLabel.leadingAnchor, constant: -8),
            
            cmLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            cmLabel.centerYAnchor.constraint(equalTo: heightInput.centerYAnchor)
        ])
    }
    
    var heightValue: String {
        return heightInput.text ?? ""
    }
    
    func setHeightValue(value: String) {
        heightInput.text = value
    }
}
