//
//  MovieTableViewCell.swift
//  unitTestingDemo
//
//  Created by M_AMBIN05643 on 13/04/22.
//

import UIKit

protocol cellTappedDelegate {
    func cellIsTapped(at row:Int)
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabelObj: UILabel!
    @IBOutlet weak var titlelabelObj: UILabel!
    
     let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var delegate: cellTappedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.size.width, height: self.contentView.bounds.size.height)
        self.addSubview(button)
        button.addTarget(self, action: #selector(cellTapped), for: .touchUpInside)
    }

    @objc func cellTapped(_ sender:UIButton){
        print("cell is tapped")
        
        delegate?.cellIsTapped(at: sender.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
