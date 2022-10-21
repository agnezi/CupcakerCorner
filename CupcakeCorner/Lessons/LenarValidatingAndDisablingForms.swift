//
//  LenarValidatingAndDisablingForms.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 18/10/22.
//

import SwiftUI

struct LenarValidatingAndDisablingForms: View {
	
	@State private var username = ""
	@State private var password = ""
	
	var body: some View {
		Form {
			Section {
				TextField("Username", text: $username)
				SecureField("Password", text: $password)
			}
			
			Section {
				Button("Create account", action: { })
			}
		}
		.preferredColorScheme(.dark)
	}
	
	var disabledSubmitButton: Bool {
		username.count < 5 || password.count < 5
	}
}

struct LenarValidatingAndDisablingForms_Previews: PreviewProvider {
	static var previews: some View {
		LenarValidatingAndDisablingForms()
	}
}
