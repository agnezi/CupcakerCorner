//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by agnezi.io on 17/10/22.
//

import SwiftUI

enum CodingKeys: CodingKey {
	case name
}

final class User: ObservableObject, Codable {
	@Published var name = "agnezi.io"
	
	init(from decode: Decoder) throws {
		let container = try decode.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	}
}

struct ContentView: View {
	@State private var results = [Result]()
	var body: some View {
		Text("Hello world")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
