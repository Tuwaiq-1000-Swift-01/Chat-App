

import Foundation
import FirebaseFirestore

struct UserSignUp {
    var name: String?
    var email: String?
    var id: String?

}

struct Message {
    let content : String?
    let sender : String?
    let reciever : String?
    let id : String?
    let timestamp : Timestamp
    
    func getNiceDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: timestamp.dateValue())
    }
}
