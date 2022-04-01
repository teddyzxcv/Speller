//
//  StringChecker.swift
//  Speller
//
//  Created by ZhengWu Pan on 01.04.2022.
//
import Foundation

class StringChecker {
    private var url: String = "https://speller.yandex.net/services/spellservice.json/checkText"
    
    private var session: URLSessionDataTask!
    
    public func loadChecks(text: String, completion: @escaping ([SpellResult])->Void ){
        if(session != nil){
            session!.cancel()
        }
        guard let url = URL(string: url + "?text=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        else {return assertionFailure()}
        session = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {data, _, _ in
            guard
                let data = data,
                let dict = try? JSONSerialization.jsonObject (with: data, options: .json5Allowed) as? [[String: Any]]
            else {return}
            let results: [SpellResult] = dict.map { params in
                let code = params["code"] as! Int
                let pos = params["pos"] as? Int
                let row = params["row"] as? Int
                let col = params["col"] as? Int
                let len = params["len"] as? Int
                let word = params["word"] as? String
                let s = params["s"] as? [String]
                return SpellResult (code: code, pos: pos!, row: row!, col: col!, len: len!, word: word!, s: s!)
            }
            completion(results)
        })
        session.resume()
    }
}
