import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var circleButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        setupButton(circleButton) // connect the settings with the button
    }

    

    func configureCell(with toDoItem: ToDoItem){
        titleLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = toDoItem.title
        descriptionLabel.text = toDoItem.description
        
    }
    
    fileprivate func setupButton(_ button: UIButton) { // button settings for choise
        let circle = UIImage(systemName: "circle")
        let circleCheckMark = UIImage(systemName: "checkmark.circle.fill")
        button.setImage(circle?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        button.setImage(circleCheckMark?.withRenderingMode(.automatic), for: .selected)
        button.tintColor = .systemBlue
    }
    
    @IBAction func circleButtonAction(_ button: UIButton) {
        button.isSelected = !button.isSelected // true or false for choise
        let textColor = button.isSelected ? UIColor.systemGray4 : UIColor.label
        titleLabel.textColor = textColor
        descriptionLabel.textColor = textColor
        
    }

}
