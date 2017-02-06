//
//  NetworkManager.swift
//  iGovFire3
//
//  Created by Ake on 12/21/16.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import Foundation
import Alamofire
import EZLoadingActivity

class NetworkManager : NSObject {
    
    static let sharedInstance = NetworkManager()
    typealias JSONStandard = [String : AnyObject]
    
    func getDates(completionHandler:@escaping (NSError?, String)->()) -> () {
        
        self.showLoading()
        
        let url = "http://data.riksdagen.se/kalender/?akt=vo&utformat=json"
        Alamofire.request(url).response(completionHandler: {
            response in
            
            self.parseDates(jsonData: response.data!, completionHandler: { (error, date) in
                
                if(date.characters.count > 0){
                    completionHandler(nil, date)
                }
            })
        })
    }
    
    func parseDates(jsonData: Data, completionHandler:@escaping (NSError?, String)->())  {
        
        do{
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let kalenderLista = readableJson["kalenderlista"] as? JSONStandard {
                if let kalender = kalenderLista["kalender"] as? [AnyObject] {
                    
                    for i in 0..<kalender.count {
                        if let arrayItems = kalender[i] as? JSONStandard {
                            let date = arrayItems["XRDREST"] as! String
                            
                            completionHandler(nil, date)
                        }
                    }
                }
            }
        } catch {
            print("Error caught in func parseDates: \(error)")
        }
    }
    
    func getDocId(date: String, completionHandler:@escaping (NSError?, String, String)->()) -> () {
        var recievedDate: String
        recievedDate = date
        let url = "http://data.riksdagen.se/\(recievedDate)/json"
        
        
        Alamofire.request(url).response(completionHandler: {
            response in
            
            let tupleIDOrgan = self.parseDocId(jsonData: response.data!)
            if(tupleIDOrgan.dok_id.characters.count > 0 && tupleIDOrgan.organName.characters.count > 0 ){
                completionHandler(nil, tupleIDOrgan.dok_id, tupleIDOrgan.organName)
            }
        })
    }
    
    func parseDocId(jsonData: Data) -> (dok_id: String, organName: String) {
        
        do {
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let aktivitetLista = readableJson["aktivitetlista"] as? JSONStandard {
                if let aktivitet = aktivitetLista["aktivitet"] as? JSONStandard {
                    if let aktivitetGrupp = aktivitet["aktivitetgrupp"] as? JSONStandard {
                        if let dokumentLista = aktivitetGrupp["dokumentlista"] as? JSONStandard {
                            if let dokument = dokumentLista["dokument"] as? [AnyObject] {
                                
                                for i in 0..<dokument.count {
                                    if let arrayItems = dokument[i] as? JSONStandard {
                                        let dok_id = arrayItems["dok_id"] as! String
                                        let organNamn = arrayItems["organnamn"] as! String
                                        
                                        return (dok_id, organNamn)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            print("Error caught in func parseDocId: \(error)")
        }
        
        return ("", "")
    }
    

    func getDocInfoFromId(dok_id: String, organ: String, completionHandler:@escaping (NSError?, Array<ParliamentInfo>)->()) -> () {
        
        var recievedDocId: String
        var recievedOrganNamn: String
        
        recievedDocId = dok_id
        recievedOrganNamn = organ
        
        let url = "http://data.riksdagen.se/dokumentstatus/\(recievedDocId).json"
        if let escapedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            Alamofire.request(escapedUrl).response(completionHandler: {
                response in
                
                let riksDagArray = self.parseDocIdInfo(jsonData: response.data!, organ: recievedOrganNamn)
                self.hideLoading()
                completionHandler(nil, riksDagArray)
                
            })
        }
        

    }
    
    func parseDocIdInfo(jsonData: Data, organ: String) -> Array<ParliamentInfo> {
        
        let organNamn = organ
        
        if jsonData.count == 0 {
            return []
        }
        
        var riksdagsArray = [ParliamentInfo]()
        do {
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let dokumentStatus = readableJson["dokumentstatus"] as? JSONStandard {
                if let dokument = dokumentStatus["dokument"] as? JSONStandard {
                    //let dokument_html = dokument["dokument_url_html"] as! String
                    
                }
                if let dokUtskottsForslag = dokumentStatus["dokutskottsforslag"] as? JSONStandard {
                    if let utskottsForslag = dokUtskottsForslag["utskottsforslag"] as? [AnyObject] {
                        
                        for i in 0..<utskottsForslag.count {
                            if let arrayItems = utskottsForslag[i] as? JSONStandard {
                                let rubrik = arrayItems["rubrik"] as! String
                                //print(rubrik)
                                let forslag = arrayItems["forslag"] as! String
                                let info = ParliamentInfo(rubrik: rubrik, organ: organNamn, forslag: forslag)
                                riksdagsArray.append(info)
                            } else {
                                //print("no objects")
                            }
                        }
                    } else {
                        //print("no utskott")
                    }
                } else {
                    ///print("no dokutskott")
                }
            } else {
                //print("no dokumentstatus")
            }
        } catch {
            print("Error in parseDocInfo: \(error)")
        }
        
        return riksdagsArray
    }
    
    
    func showLoading()
    {
        EZLoadingActivity.show("Loading...", disableUI: true)
    }
    
    func hideLoading()
    {
        EZLoadingActivity.hide(true, animated: true)
    }
    
}
