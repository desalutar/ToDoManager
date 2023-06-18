import UIKit

protocol TableViewCellDelegate: AnyObject {
    func cell(_: TableViewCell, didSelectedAt indexPath: IndexPath)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var circleButton: UIButton!
    
    private var selectedIndexPath: IndexPath?
    
    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        
    }

    
    
    func configureCell(with toDoItem: ToDoItem, indexPath: IndexPath){
        titleLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = toDoItem.title
        descriptionLabel.text = toDoItem.description
        
        setupButton(toDoItem)
        setupLabels(toDoItem)
        
        selectedIndexPath = indexPath
    }
    
    fileprivate func setupLabels(_ toDoItem: ToDoItem) { // here we change the color of the labels when you click on the button
        let textColor = toDoItem.isCompleted ? UIColor.systemGray4 : UIColor.label
        titleLabel.textColor = textColor
        descriptionLabel.textColor = textColor
    }
    
    fileprivate func setupButton(_ todoItem: ToDoItem) { // button settings for choise
        let circle = UIImage(systemName: "circle")
        let circleCheckMark = UIImage(systemName: "checkmark.circle.fill")
        let buttonImage = todoItem.isCompleted ? circleCheckMark : circle
        circleButton.setImage(buttonImage, for: .normal)
        
    }
    
    @IBAction func circleButtonAction(_ button: UIButton) {
        guard let indexPath = selectedIndexPath else { return }
        delegate?.cell(self, didSelectedAt: indexPath)
    }

}
