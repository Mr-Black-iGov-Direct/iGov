//
//  RiksdagsDocs.swift
//  iGovFire3
//
//  Created by iGov Direct on 2016-11-01.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import Foundation
import Alamofire

class RiksdagsDocs {
    
    /*var riksdagsArray = [RiksdagsInfoArray]()
    
    typealias JSONStandard = [String : AnyObject]
    
    func getDates() {
        
        let url = "http://data.riksdagen.se/kalender/?akt=vo&utformat=json"
        Alamofire.request(url).response(completionHandler: {
            response in
            
            self.parseDates(jsonData: response.data!)
        })
    }
    
    func parseDates(jsonData: Data) {
        
        do{
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let kalenderLista = readableJson["kalenderlista"] as? JSONStandard {
                if let kalender = kalenderLista["kalender"] {
                    
                    for i in 0..<kalender.count {
                        if let arrayItems = kalender[i] as? JSONStandard {
                            let date = arrayItems["XRDREST"] as! String
                            getDocId(date: date)
                            /*let dateInfo = RiksdagsDate(date: date)
                             self.dateArray.append(dateInfo)*/
                        }
                    }
                }
            }
        } catch {
            print("Error caught in func parseDates: \(error)")
        }
    }
    
    func getDocId(date: String) {
        var recievedDate: String
        recievedDate = date
        let url = "http://data.riksdagen.se/\(recievedDate)/json"
        Alamofire.request(url).response(completionHandler: {
            response in
            
            self.parseDocId(jsonData: response.data!)
        })
        
    }
    
    func parseDocId(jsonData: Data) {
        
        do {
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let aktivitetLista = readableJson["aktivitetlista"] as? JSONStandard {
                if let aktivitet = aktivitetLista["aktivitet"] as? JSONStandard {
                    if let aktivitetGrupp = aktivitet["aktivitetgrupp"] as? JSONStandard {
                        if let dokumentLista = aktivitetGrupp["dokumentlista"] as? JSONStandard {
                            if let dokument = dokumentLista["dokument"] {
                                
                                for i in 0..<dokument.count {
                                    if let arrayItems = dokument[i] as? JSONStandard {
                                        let dok_id = arrayItems["dok_id"] as! String
                                        let organNamn = arrayItems["organnamn"] as! String
                                        getDocInfoFromId(dok_id: dok_id, organ: organNamn)
                                        
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
    }
    
    func getDocInfoFromId(dok_id: String, organ: String) {
        
        var recievedDocId: String
        var recievedOrganNamn: String
        
        recievedDocId = dok_id
        recievedOrganNamn = organ
        
        let url = "http://data.riksdagen.se/dokumentstatus/\(recievedDocId).json"
        Alamofire.request(url).response(completionHandler: {
            response in
            
            self.parseDocIdInfo(jsonData: response.data!, organ: recievedOrganNamn)
        })
    }
    
    func parseDocIdInfo(jsonData: Data, organ: String) {
        
        let organNamn = organ
        
        do {
            var readableJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            if let dokumentStatus = readableJson["dokumentstatus"] as? JSONStandard {
                if let dokument = dokumentStatus["dokument"] as? JSONStandard {
                    //let dokument_html = dokument["dokument_url_html"] as! String
                    //print(dokument_html)
                }
                if let dokUtskottsForslag = dokumentStatus["dokutskottsforslag"] as? JSONStandard {
                    if let utskottsForslag = dokUtskottsForslag["utskottsforslag"] {
                        
                        for i in 0..<utskottsForslag.count {
                            if let arrayItems = utskottsForslag[i] as? JSONStandard {
                                let rubrik = arrayItems["rubrik"] as! String
                                let forslag = arrayItems["forslag"] as! String
                                let info = RiksdagsInfoArray(rubrik: rubrik, organ: organNamn, forslag: forslag)
                                self.riksdagsArray.append(info)
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
    }*/

}
