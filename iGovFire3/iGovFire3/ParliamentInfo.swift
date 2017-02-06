//
//  RiksdagsInfoArray.swift
//  iGovFire3
//
//  Created by iGov Direct on 2016-11-03.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import Foundation

class ParliamentInfo {
    
    var rubrik: String
    var organ: String
    var forslag: String
    //var dok_html: String
    
    init(rubrik: String, organ: String, forslag: String) {
        self.rubrik = rubrik
        self.organ = organ
        self.forslag = forslag
        //self.dok_html = dok_html
    }
    
}
