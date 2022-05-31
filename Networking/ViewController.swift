//
//  ViewController.swift
//  Networking
//
//  Created by Diyorbek Hamdamov on 31/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url="https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400"
        getData(from:url)
    }
    func getData(from url:String){
      let task = URLSession.shared.dataTask(with: URL(string:url)!, completionHandler:{ data,response,error in
            guard let data=data , error==nil else{
                print("Errorrrrrrrrrrrr")
                return
            }
            
            var result:Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }catch{
                print("cant convert\(error)")
            }
            
            guard let json = result else{
                return
            }
          print(json.status)
          print(json.result.day_length)
//            print(json.result.astronomical_twilight_end)
//            print(json.result.civil_twilight_begin)
//            print(json.result.civil_twilight_end)
        })
        
        task.resume()
    }

}


struct Response:Codable{
    let result:MyResult
    let status:String
}
struct MyResult:Codable{
    let sunrise:String
    let sunset:String
    let solar_noon:String
    let day_length:Int
    let civil_twilight_begin:String
    let civil_twilight_end:String
    let nautical_twilight_begin:String
    let nautical_twilight_end:String
    let astronomical_twilight_begin:String
    let astronomical_twilight_end:String
}
