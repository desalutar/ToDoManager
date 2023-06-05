import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreateToDo(todo: ToDoItem)
    func didUpdateToDo(todo: ToDoItem)
    func didDeleteToDo() // method for delete button
}

class AddTaskViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    
    enum controllerType {
        case create
        case edit
        case none
    }
    
    var type = controllerType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // вынеси этот код в отдельный метод и вызови его отсюда
        // подумай над названием. Метод должен как бы говорить своим названием что он делает
        // вот как на примере: `configure`
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.discription
    }
    
    // @IBAction private func myButton(_ sender: UIButton)
    // медод сделай приватным, и ты же знаешь кто у тебя сендер. Зачем тут Any ?
    @IBAction func myButton(_ sender: Any) {
        // 💩💩💩 Убрать форс анврап. За это могут спросить и будут бить по рукам
        let todoFromTappedButton = ToDoItem(title: textField.text!, discription: textView.text!)
        
        switch type {
        case .create:
            delegate?.didCreateToDo(todo: todoFromTappedButton) // here we send data to the object who is subscribed to our delegate
            dismiss(animated: true)
        case .edit:
            delegate?.didUpdateToDo(todo: todoFromTappedButton)
            navigationController?.popViewController(animated: true)
        case .none:
            // А почему Error ? разве тут ошибка ?
            // я что, если передам .none ?
            // И даже если ошибка, как ты ее обрабатываешь ? Что пользователь увидит ?
            // ❌ исправь тут. Подумай как
            print("Error")
        }
    }
    
    // 💩 строки опять. По хорошему вот такие строки должный быть локализированны
    // поищи инфу про локализацию и прикрути сюда.
    // Так больше делать нельзя!
    @IBAction func deleteButtonAction(_ sender: UIButton) { // add delete button
        let alert = UIAlertController(title: "Вы точно хотите удалить ?",
                                      message: "выберите одно действие",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Назад", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            self.dismiss(animated: true)
            self.delegate?.didDeleteToDo()
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}


// ⚠️ Удали это пожалуйста, это мертвый код 
extension AddTaskViewController: UITextFieldDelegate {
    
}
