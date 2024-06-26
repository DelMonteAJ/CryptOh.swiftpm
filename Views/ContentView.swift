import SwiftUI


struct ContentView: View {
    @State var view: Int = 0
    @State var input: String = ""
    @State var passwordCrackTime: Double = 0.0
    @State var preferences: CryptOhPreferences = decodePreferences()

//    @State var
    var body: some View {
        
        if (view <= 0) {
            TitleView(page: $view, preferences: $preferences)
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
            PasswordSafetyView(page: $view, preferences: $preferences)
        }else if (view == 7){
            CompletedTutorialView(page: $view)
        }else if (view == 8){
            TitleView(page: $view, preferences: $preferences, showManager: true)
        }
    }
}


