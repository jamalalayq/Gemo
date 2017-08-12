//  Gemo.swift
//  Gemo
//  Created by Tech-world on 8/1/17.
//  Copyright © 2017 servarena. All rights reserved.

import Foundation
import SystemConfiguration

/// Main class: every thing will invoked from it
public final class Gemo {
    
    
    // MARK: - Functions 
    
    
    /// http: use it to connect with server
    public class func request(link: string, method: Method, parameters: [string: any] = [:]) -> Response {        
        return Http().request(link: link, method: method, parameters: parameters)
    }
    
    /// http: using multipart tech
    public class func upload(_ images: ()->[Media]?, and paramters: Paramters?, to link: string) -> Response {
        return Http().upload(from: paramters, and: images, to: link)
    }
    
    
}



// MARK: - Computed properties

public extension Gemo {
    
    /// check internet connection
    public var isConnected: bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }

    
}


















































