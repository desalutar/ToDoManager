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
        titleLabel.adjustsFontSizeToFitWidth = true
        discripriptionLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = toDoItem.title
        discripriptionLabel.text = toDoItem.discription
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            titleLabel.textColor = .lightGray
            discripriptionLabel.textColor = .lightGray
        } else {
            titleLabel.textColor = .black
            discripriptionLabel.textColor = .black
        }
    }

}
