import UIKit

protocol TableViewCellDelegate: AnyObject {
    func cell(_: ToDoCell, didSelectedAt indexPath: IndexPath)
}



final class ToDoCell: UITableViewCell {

    private let circleImage = "circle"
    private let checkMarkCircle = "checkmark.circle.fill"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var imageViewInCell: UIImageView!
    
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
        imageViewInCell.image = toDoItem.picture
        
        setupButton(toDoItem)
        setupLabels(toDoItem)
        
        selectedIndexPath = indexPath
    }
    
    func setupLabels(_ toDoItem: ToDoItem) { // here we change the color of the labels when you click on the button
        let textColor = toDoItem.isCompleted ? UIColor.systemGray4 : UIColor.label
        titleLabel.textColor = textColor
        descriptionLabel.textColor = textColor
    }
    
    func setupButton(_ todoItem: ToDoItem) { // button settings for choise
        let circle = UIImage(systemName: circleImage)
        let circleCheckMark = UIImage(systemName: checkMarkCircle)
        let buttonImage = todoItem.isCompleted ? circleCheckMark : circle
        circleButton.setImage(buttonImage, for: .normal)
        
    }
    
    @IBAction func circleButtonAction(_ button: UIButton) {
        guard let indexPath = selectedIndexPath else { return }
        delegate?.cell(self, didSelectedAt: indexPath)
    }

}
