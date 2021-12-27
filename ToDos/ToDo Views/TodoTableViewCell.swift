//
//  TodoTableViewCell.swift
//  ToDo
//
//  Created by BE X on 29/04/1443 AH.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
 // cell class n m
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var TodoImgView: UIImageView!
    @IBOutlet weak var TodoDate: UILabel!
    @IBOutlet weak var viewCel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TodoImgView.layer.cornerRadius = TodoImgView.frame.height / 2
        TodoImgView.layer.borderWidth = 3
        TodoImgView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        TodoImgView.clipsToBounds = true
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
