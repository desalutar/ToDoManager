import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    

    func configureCell(with toDoItem: ToDoItem){
        titleLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = toDoItem.title
        descriptionLabel.text = toDoItem.description
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            titleLabel.textColor = .systemGray4
            descriptionLabel.textColor = .systemGray4
        } else {
            titleLabel.textColor = .label
            descriptionLabel.textColor = .label
        }
    }

}
