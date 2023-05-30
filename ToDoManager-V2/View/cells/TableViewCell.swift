//
//  TableViewCell.swift
//  ToDoManager-V2
//
//  Created by Ишхан Багратуни on 27.05.23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discripriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configuriCell(with toDoItem: ToDoItem){
        titleLabel.text = toDoItem.title
        discripriptionLabel.text = toDoItem.discription
    }

}
