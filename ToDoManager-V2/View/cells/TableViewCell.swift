import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    // очепятка: descriptionLabel
    @IBOutlet weak var discripriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    // этот didSelected у тебя ничего не делает. Такой код старайся удалять
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    // очепятка: configureCell
    func configuriCell(with toDoItem: ToDoItem){
        titleLabel.adjustsFontSizeToFitWidth = true
        discripriptionLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = toDoItem.title
        discripriptionLabel.text = toDoItem.discription
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            // цвета нельзя сетить (устанавливать) напрямую вот как тут.
            // Сделай эксперимент. Запусти приложение в темной теме - и будешь неприятно удивлен эффектом )
            // для установки цвета используй динамичекие цвета
            // например: titleLabel.textColor = .systemGray4
            titleLabel.textColor = .lightGray
            discripriptionLabel.textColor = .lightGray
        } else {
            // А тут: titleLabel.textColor = .label
            titleLabel.textColor = .black
            discripriptionLabel.textColor = .black
        }
    }

}
