//
//  MonthSlider.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/30/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class MonthSlider: UIStackView {
    
    private var monthButtons = [UIButton]()
    var delegate: MonthSliderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func resetBackgroundColors() {
        for button in monthButtons {
            button.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            button.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        resetBackgroundColors()
        button.backgroundColor = UIColor(red:0.84, green:0.86, blue:0.87, alpha:1.0)
        button.setTitleColor(UIColor.white, for: .normal)
        
        if let delegate = self.delegate {
            delegate.monthSelected(month: button.tag)
        }
    }
    
    private func setupButtons() {
        for index in 1...12 {
            let button = UIButton()
            button.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            var title = ""
            switch index {
            case 1:
                title = "JAN"
            case 2:
                title = "FEB"
            case 3:
                title = "MAR"
            case 4:
                title = "APR"
            case 5:
                title = "MAY"
            case 6:
                title = "JUN"
            case 7:
                title = "JUL"
            case 8:
                title = "AUG"
            case 9:
                title = "SEP"
            case 10:
                title = "OCT"
            case 11:
                title = "NOV"
            case 12:
                title = "DEC"
            default:
                title = ""
            }
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 22.0).isActive = true
            
            
            button.addTarget(self, action: #selector(MonthSlider.ratingButtonTapped(button:)), for: .touchUpInside)
            
            let buttonView = UIView()
            buttonView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            buttonView.translatesAutoresizingMaskIntoConstraints = false
            buttonView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            buttonView.addSubview(button)
            
            button.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.6).isActive = true
            button.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            addArrangedSubview(buttonView)
            
            monthButtons.append(button)
        }
    }
}

protocol MonthSliderDelegate {
    func monthSelected(month: Int)
}
