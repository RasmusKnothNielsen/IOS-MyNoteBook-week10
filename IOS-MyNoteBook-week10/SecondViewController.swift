//
//  SecondViewController.swift
//  
//
//  Created by Rasmus Knoth Nielsen on 26/06/2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var headText: UITextView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UITextField!
    
    var text = ""

    override func viewDidLoad() {
        print("Now we are in secondViewController")
        super.viewDidLoad()
        let newNote = CloudStorage.getNote(index: rowThatIsBeingEdited)
        headText.text = newNote.head
        bodyText.text = newNote.body
        
        CloudStorage.downloadImage(name: newNote.imageID, iv: self.imageView)
        print("Row that is being edited: \(rowThatIsBeingEdited)")
        print()
        
    
    }
    
    @IBAction func userPressedSaveButton(_ sender: UIButton) {
        print("Pressed the save button")
        print(headText.text!)
        print(rowThatIsBeingEdited)
        let fullImageName = (imageName.text ?? "default") + ".jpg"
        _ = CloudStorage.getNote(index: rowThatIsBeingEdited)
        CloudStorage.updateNote(index: rowThatIsBeingEdited, head: headText.text, body: bodyText.text, imageID: fullImageName )
        print("Image name is now: \(imageName.text!)")
        print(imageView.image!)
        // Upload the picture from the imageView if it differs from before.
        CloudStorage.uploadImage(name: imageName.text!, image: imageView.image!)
        
    }

    @IBAction func userPressedUpload(_ sender: UIButton) {
        print("User pressed upload")
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            print("user choose Photo Library")
            self.imageView.image = image
            self.imageName.text = UUID().uuidString
            print(self.imageName.text!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

