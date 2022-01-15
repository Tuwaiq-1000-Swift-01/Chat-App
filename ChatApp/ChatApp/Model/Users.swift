

import UIKit

struct UserSignUp {
    var name: String?
    var email: String?
    var password: String?
    
  func getData() -> [String:Any] {
    return ["User Name": name!,
            "User Email": email!,
            "User Password": password!]
    
  }
  }
  
