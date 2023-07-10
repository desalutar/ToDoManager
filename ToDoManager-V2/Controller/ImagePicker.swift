import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    func imageSelection(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        viewController.present(imagePicker!, animated: true)
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else { return }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = selectedSource
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
