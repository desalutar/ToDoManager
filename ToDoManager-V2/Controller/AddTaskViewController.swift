import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreateToDo(todo: ToDoItem)
    func didUpdateToDo(todo: ToDoItem)
    func didDeleteToDo()
}

final class AddTaskViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    static let saveButton: String = "save_button".locolized
    static let deleteButton: String = "delete_button".locolized
    static let placeholderForTextView: String = "placeholder_for_the_task_header".locolized
    static let title: String = "title_of_the_deletion_pop_up_window".locolized
    static let message: String =  "description_of_the_pop_up_deletion_window".locolized
    static let titleBack: String = "canceling_confirmation_of_deletion".locolized
    static let titleDelete: String = "confirmation_of_deletion".locolized
    
    var selectedImage: UIImage?
    
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
        textViewSettings()
    }
    
    fileprivate func textViewSettings() {
        textView.layer.borderWidth = 3
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    fileprivate func delegateStorage() {
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.description
        selectedImage = todos.picture
    }
    
    @IBAction private func buttonSaveTodo(_ sender: UIButton) {
        sender.setTitle(AddTaskViewController.saveButton, for: .normal)
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
        sender.isHidden = true
    }
    
    @IBAction private func deleteButtonAction(_ sender: UIButton) { // add delete button
        sender.setTitle(AddTaskViewController.deleteButton, for: .normal)
        let alert = UIAlertController(title: AddTaskViewController.title,
                                      message: AddTaskViewController.message,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: AddTaskViewController.titleBack, style: .cancel))
        alert.addAction(UIAlertAction(title: AddTaskViewController.titleDelete,
                                      style: .destructive,
                                      handler: { (action) in
            self.dismiss(animated: true)
            self.delegate?.didDeleteToDo()
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray4 {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = AddTaskViewController.placeholderForTextView
            textView.textColor = .systemGray4
        }
    }
    
    @IBAction func addPhotoInToDo(_ sender: Any) {
        let imagePicker = ImagePicker()
        imagePicker.imageSelection(in: self) { image in
            self.selectedImage = image
        }
    }
}
