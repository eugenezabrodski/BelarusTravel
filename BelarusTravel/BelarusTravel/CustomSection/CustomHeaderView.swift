//
//  CustomHeaderView.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 6.02.23.
//

import UIKit

protocol HeaderViewDelegate: class {
    func expandedSection(button: UIButton)
}

class CustomHeaderView: UITableViewHeaderFooterView {

    weak var delegate: HeaderViewDelegate?
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var textButton: UIButton!
    
    func configure(title: String, section: Int) {
        infoLabel.text = title
        textButton.tag = section
        }
    
    func rotateImage(_ expanded: Bool) {
            if expanded {
                textButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            } else {
                textButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
            }
        }
   
    @IBAction func actionButton(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
