import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let url = "https://api.content.tripadvisor.com/api/v1/location/114514/details?key=547B30F2C5CF4458B82FAC44F069D0FA"


struct Location: Decodable{
  let id: String
  let name: String
  let description: String
  let url: String
  let address: Address
  let rank: Rank
  let review: Review
  let amenities: [String]
  let styles: [String]
  
  enum CodingKeys: String, CodingKey{
    case id = "location_id"
    case name = "name"
    case description = "description"
    case url = "web_url"
    case address = "address_obj"
    case rank = "ranking_data"
    case review = "review_rating_count"
    case amenities = "amenities"
    case styles = "styles"
  }
}

struct Review: Decodable {
  let rank_1_num : String
  let rank_2_num: String
  let rank_3_num: String
  let rank_4_num: String
  let rank_5_num: String
  
  enum CodingKeys: String, CodingKey{
    case rank_1_num = "1"
    case rank_2_num = "2"
    case rank_3_num = "3"
    case rank_4_num = "4"
    case rank_5_num = "5"
  }
}
  
struct Rank: Decodable{
  let ranking_string: String
  
  enum CodingKeys: String, CodingKey{
    case ranking_string = "ranking_string"
  }
}




struct Address: Decodable{
  let street1: String
  let street2: String
  let city: String
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
    

    guard let location = try? JSONDecoder().decode(Location.self, from: data) else {
      print("Error: Couldn't decode data into a result")
      return
    }

    // Output if everything is working right
    print("Location id: \(location.id)")
    print("Description: \(location.description)")
    print("web_url: \(location.url)")
    print("address state: \(location.address.state)")
    print("address city: \(location.address.city)")
    print("address country: \(location.address.country)")
    print("address string: \(location.address.address_string)")
    print("--------------------------------------------------------------------")
    print("address rank description: \(location.rank.ranking_string)")
    print("number of 1 star rating: \(location.review.rank_1_num)")
    print("number of 2 star rating: \(location.review.rank_2_num)")
    print("number of 3 star rating: \(location.review.rank_3_num)")
    print("number of 4 star rating: \(location.review.rank_4_num)")
    print("number of 5 star rating: \(location.review.rank_5_num)")
    print("--------------------------------------------------------------------")
    print("amenities of the location: \(location.amenities)")
    print("--------------------------------------------------------------------")
    print("stype of the location: \(location.styles)")
  }
  
  task.resume()
