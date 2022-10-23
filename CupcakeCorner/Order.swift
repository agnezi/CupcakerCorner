//
//  Order.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 19/10/22.
//

import Foundation

//enum CodingKeys: CodingKey {
//	case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
//}


//class Order: ObservableObject, Codable {
//	static let types = ["Vanilla", "Rainbow", "Strawberry", "Chocolate"]
//
//	@Published var type = 0
//	@Published var quantity = 3
//
//	@Published var specialRequestEnabled = false {
//		didSet {
//			if specialRequestEnabled == false {
//				extraFrosting = false
//				addSprinkles = false
//			}
//		}
//	}
//	@Published var extraFrosting = false
//	@Published var addSprinkles = false
//
//	@Published var name = "A"
//	@Published var streetAddress = "S"
//	@Published var city = "D"
//	@Published var zip = "F"
//
// 	let regex = try! Regex("[A-Z]")
//	let regexNumberText = try! Regex("[A-Z]|[0-9]")
//
//
//	var hasValidAddress: Bool {
//		if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
//			return false
//		}
//
//		if name.firstMatch(of: regex) == nil || streetAddress.firstMatch(of: regex) == nil || city.firstMatch(of: regex) == nil || zip.firstMatch(of: regexNumberText) == nil {
//			return false
//		}
//
//		return true
//	}
//
//	var cost: Double {
//		// $2 per cake
//		var cost = Double(quantity) * 2
//
//		// complicated cake cost more
//		cost += (Double(type) / 2)
//
//		// $1/cake for extra frosting
//		if extraFrosting {
//			cost += Double(quantity)
//		}
//
//		// $0.50/cake for sprinkles
//		if addSprinkles {
//			cost += Double(quantity) / 2
//		}
//
//		return cost
//	}
//
//	init() { }
//
//
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//
//		try container.encode(type, forKey: .type)
//		try container.encode(quantity, forKey: .quantity)
//		try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
//		try container.encode(extraFrosting, forKey: .extraFrosting)
//		try container.encode(addSprinkles, forKey: .addSprinkles)
//		try container.encode(name, forKey: .name)
//		try container.encode(streetAddress, forKey: .streetAddress)
//		try container.encode(city, forKey: .city)
//		try container.encode(zip, forKey: .zip)
//
//	}
//
//
//	required init(from decoder: Decoder) throws {
//
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//
//		type = try container.decode(Int.self, forKey: .type)
//		quantity = try container.decode(Int.self, forKey: .quantity)
//		specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
//		extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//		addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//		name = try container.decode(String.self, forKey: .name)
//		streetAddress = try container.decode(String.self, forKey: .streetAddress)
//		city = try container.decode(String.self, forKey: .city)
//		zip = try container.decode(String.self, forKey: .zip)
//	}
//
//}


enum CodingKeys: CodingKey {
	case data
}

class Order: ObservableObject {
	
	struct OrderStruct: Codable {
		static let types = ["Vanilla", "Rainbow", "Strawberry", "Chocolate"]
		
		var type = 0
		var quantity = 3
		
		var specialRequestEnabled = false {
			didSet {
				if specialRequestEnabled == false {
					extraFrosting = false
					addSprinkles = false
				}
			}
		}
		var extraFrosting = false
		var addSprinkles = false
		
		var name = "A"
		var streetAddress = "S"
		var city = "D"
		var zip = "F"
		
		let regex = try! Regex("[A-Z]")
		let regexNumberText = try! Regex("[A-Z]|[0-9]")
		
		var hasValidAddress: Bool {
			if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
				return false
			}
			
			if name.firstMatch(of: regex) == nil || streetAddress.firstMatch(of: regex) == nil || city.firstMatch(of: regex) == nil || zip.firstMatch(of: regexNumberText) == nil {
				return false
			}
			
			return true
		}
		
		var cost: Double {
			// $2 per cake
			var cost = Double(quantity) * 2
			
			// complicated cake cost more
			cost += (Double(type) / 2)
			
			// $1/cake for extra frosting
			if extraFrosting {
				cost += Double(quantity)
			}
			
			// $0.50/cake for sprinkles
			if addSprinkles {
				cost += Double(quantity) / 2
			}
			
			return cost
		}
		
		private enum CodingKeys: CodingKey {
			case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
		}
		
	}
	
	@Published var data: OrderStruct
	
	init() {
		data = OrderStruct()
	}
}

