

import UIKit
import Firebase

class LogInViewController: UIViewController {

  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    }

  
  @IBAction func logInButtonPressed(_ sender: Any) {
    Auth.auth().signIn(withEmail: emailTF.text!,
                       password: passwordTF.text!) { user, error in
        if error == nil {
            self.performSegue(withIdentifier: "goToChat", sender: self)

        }else{
            print(error?.localizedDescription)
        }
    }
  }
  
}

