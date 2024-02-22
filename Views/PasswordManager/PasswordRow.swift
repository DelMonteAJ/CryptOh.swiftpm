import SwiftUI

struct PasswordRow: View {
    let password: Password
    var body: some View {
        HStack {
            Text(password.id)
            Spacer()
        }
    }
}

#Preview {
    PasswordRow(password: Password(id: "Apple.com", account_name: "timmy_c", password: "Testser"))
}
