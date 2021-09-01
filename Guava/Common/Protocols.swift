//
//  Protocols.swift
//  Guava
//
//  Created by Savage on 31/8/21.
//

import Foundation

protocol ChannelVCDelegate {
    
    /// user comes back to Edit Page after selecting a topic
    /// - Parameter channel: pass channel to Edit Page
    /// - Parameter subChannel: pass subChannel to Edit Page
    func updateChannel(channel: String, subChannel: String)
    
    /// <#Description#>
    /// - Parameter <#name#>: <#description#>
    /// - Parameter <#name#>  <#description#>
    /// - Returns:

}

protocol POIVCDelegate {
    func updatePOIName(_ poiName: String)
}
