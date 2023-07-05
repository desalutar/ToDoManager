import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreateToDo(todo: ToDoItem)
    func didUpdateToDo(todo: ToDoItem)
    func didDeleteToDo()
}

// Давай этот класс тоже сделаем `final`
class AddTaskViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    // Это должно переехать в локализированные строки
    enum AlertString {
        static let placeholderForTextView: String = "Введите описание."
        
        static let title: String = "Вы точно хотите удалить ?"
        static let message: String =  "Выберите одно действие"
        
        static let titleBack: String = "Назад"
        static let titleDelete: String = "Удалить"
    }
    
    enum controllerType {
        case create
        case edit
        case none
    }
    var type = controllerType.none
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateStorage()
        textViewDidBeginEditing(textView)
        textViewDidEndEditing(textView)
        
    }
    
    // Почему `fileprivate` а не `private` ?
    // Хотя я знаю почему, мне интересно ты знаешь ?
    fileprivate func delegateStorage() {
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.description
    }
    
    // 💩 что за название action `myButton` ? Что мне этот метод должен сказать ?
    // название метода должно описывать то, что он делает
    @IBAction private func myButton(_ sender: UIButton) {
        let todoFromTappedButton = ToDoItem(title: textField.text ?? "", description: textView.text)
        
        switch type {
        case .create:
            delegate?.didCreateToDo(todo: todoFromTappedButton) // here we send data to the object who is subscribed to our delegate
            dismiss(animated: true)
        case .edit:
            delegate?.didUpdateToDo(todo: todoFromTappedButton)
            navigationController?.popViewController(animated: true)
        case .none:
            break
        }
    }
    
    @IBAction func closeModalButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction private func deleteButtonAction(_ sender: UIButton) { // add delete button
        let alert = UIAlertController(title: AlertString.title,
                                      message: AlertString.message,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: AlertString.titleBack, style: .cancel))
        alert.addAction(UIAlertAction(title: AlertString.titleDelete,
                                      style: .destructive,
                                      handler: { (action) in
            self.dismiss(animated: true)
            self.delegate?.didDeleteToDo()
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // тут завязываться на цвет лейбла, не очень хорошая идея. Пока оставь так, но в следующих итерациях мы подрефачим архитектуру и сделаем по красоте
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = AlertString.placeholderForTextView
            textView.textColor = .lightGray
        }
    }
}
