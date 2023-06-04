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
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.discription
    }
    
    
    @IBAction func myButton(_ sender: Any) {
        let todoFromTappedButton = ToDoItem(title: textField.text!, discription: textView.text!)
        
        switch type {
        case .create:
            delegate?.didCreateToDo(todo: todoFromTappedButton) // here we send data to the object who is subscribed to our delegate
            dismiss(animated: true)
        case .edit:
            delegate?.didUpdateToDo(todo: todoFromTappedButton)
            navigationController?.popViewController(animated: true)
        case .none:
            print("Error")
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) { // add delete button
        let alert = UIAlertController(title: "Вы точно хотите удалить ?",
                                      message: "выберите одно действие",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Назад", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            self.delegate?.didDeleteToDo()
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
        }
}



extension AddTaskViewController: UITextFieldDelegate {
    
}
