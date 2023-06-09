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
    
    @IBAction func circleButton(_ sender: UIButton) {
        let circle = UIImage(systemName: "circle")
        let circleCheckMark = UIImage(systemName: "checkmark.circle.fill")
        sender.setImage(circle?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        sender.setImage(circleCheckMark?.withRenderingMode(.automatic), for: .selected)
        
        sender.isSelected = !sender.isSelected
        

    }

}
