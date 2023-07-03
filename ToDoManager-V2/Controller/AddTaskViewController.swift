import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreateToDo(todo: ToDoItem)
    func didUpdateToDo(todo: ToDoItem)
    func didDeleteToDo()
}

class AddTaskViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
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
        textView.text = AlertString.placeholderForTextView
        textView.textColor = UIColor.lightGray
    }
    
    fileprivate func delegateStorage() {
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.description
    }
    
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingOccurrences(of: text, with: text)
        
        if updatedText.isEmpty {
            textView.text = AlertString.placeholderForTextView
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        } else {
            return true
        }
        return false
    }
}
