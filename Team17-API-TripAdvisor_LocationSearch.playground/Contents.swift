//this demo shows what will be returned if Pittsburgh is used as search query
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let url = "https://api.content.tripadvisor.com/api/v1/location/search?searchQuery=Pittsburgh&language=en&key=547B30F2C5CF4458B82FAC44F069D0FA"

struct Answer: Decodable{
  let data: [Location]
  
  enum CodingKeys: String, CodingKey{
    case data = "data"
  }
}

struct Location: Decodable {
  let id: String
  let name: String
  let address: Address
  
  enum CodingKeys: String, CodingKey {
    case id = "location_id"
    case name = "name"
    case address = "address_obj"
  }
}

struct Address: Decodable{
  let street1: String?
  let street2: String?
  let city: String?
  let state: String
  let country: String
  let address_string: String
  
  enum CodingKeys: String, CodingKey{
    case street1 = "street1"
    case street2 = "street2"
    case city = "city"
    case state = "state"
    case country = "country"
    case address_string = "address_string"
  }
}

let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
    guard let data = data else {
      print("Error: No data to decode")
      return
    }

    guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
      print("Error: Couldn't decode data into a result")
      return
    }
    
  
    for location in answer.data {
      print("The \(location.name) 's id is \(location.id)")
    }
  
    print("--------------------------------------------------------------------")
  
    for location in answer.data {
      print("The \(location.name) 's address is \(location.address.address_string)")
    }
  
}
  
  task.resume()
