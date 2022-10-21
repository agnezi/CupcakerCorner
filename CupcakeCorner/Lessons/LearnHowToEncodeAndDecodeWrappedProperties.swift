//
//  LearnHowToEncodeAndDecodeWrappedProperties.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 19/10/22.
//

import SwiftUI

//enum CodingKeys: CodingKey {
//	case name
//}
//
//final class User: ObservableObject, Codable {
//	@Published var name = "itsjagnezi"
//	
//	init(from decode: Decoder) throws {
//		let container = try decode.container(keyedBy: CodingKeys.self)
//		name = try container.decode(String.self, forKey: .name)
//	}
//	
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(name, forKey: .name)
//	}
//}
//

struct LearnHowToEncodeAndDecodeWrappedProperties: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LearnHowToEncodeAndDecodeWrappedProperties_Previews: PreviewProvider {
    static var previews: some View {
        LearnHowToEncodeAndDecodeWrappedProperties()
    }
}
