import SwiftUI
import LocalAuthentication

//https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui
func authenticate() {
    let context = LAContext()
    var error: NSError?

    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
        // it's possible, so go ahead and use it
        let reason = "We are unlocking your CryptOh passwords."

        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
            // authentication has now completed
            if success {
                print("IN")
                // authenticated successfully
            } else {
                print("OUT")
                // there was a problem
            }
        
        }
    } else {
        print("NO")
        // no biometrics
    }
}

struct ContentView: View {
    @State var view: Int = 7
    @State var input: String = ""
    @State var passwordCrackTime: Double = 0.0

//    @State var
    var body: some View {
        
        if (view == 0) {
            TitleView(page: $view)
        }else if (view == 1) {
            BadPasswordView(password: $input, time: $passwordCrackTime, page: $view)
        }else if (view == 2){
            CompanyHashingView(page: $view)
        }else if (view == 3){
            HasherView(input: $input, time: passwordCrackTime, page: $view)
        }else if (view == 4){
            HashQuestionView(page: $view)
        }else if (view == 5){
            NewPasswordView(password: $input, page: $view)
        }else if (view == 6){
            PasswordSafetyView(page: $view)
        }else if (view == 7){
            PasswordDatabaseView()
//                .onAppear(perform: authenticate)
        }
    }
}


