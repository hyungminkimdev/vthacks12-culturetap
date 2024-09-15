//
//  ConnectDevicesSession.swift
//  CultureTap
//
//  Created by Harditya Sarvaiya on 9/14/24.
//

import MultipeerConnectivity
import os

//struct UserProfile: Codable {
//    let name: String
//    let age: Int
//    let city: String
//    // Add any other fields you need
//}

class ConnectDevicesSession: NSObject, ObservableObject {
    
    // serviceType identifies the service
    // (It must be a unique string up to 15 characters long and may only contain ASCII lowercase letters, numbers, and hyphens).


//    @Published var userProfile: UserProfile? = UserProfile(
//        name: "John Doe",
//        age: 25,
//        city: "hd"
//    )

    @Published var userProfile: UserProfile? = nil
    
    private let serviceType = "data-transfer"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    public let session: MCSession
    private let log = Logger()
    
    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
        
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func send(profile: UserProfile) {
        log.info("Sending user profile to \(self.session.connectedPeers.count) peers")
        
        if !session.connectedPeers.isEmpty {
            do {
                // Convert the UserProfile to JSON data
                let jsonData = try JSONEncoder().encode(profile)
                
                // Send the JSON data
                try session.send(jsonData, toPeers: session.connectedPeers, with: .reliable)
                log.info("User profile sent successfully")
            } catch {
                log.error("Error sending user profile: \(error)")
            }
        } else {
            log.warning("No connected peers")
            log.info("Session: \(self.session.connectedPeers)")
        }
    }
    
    @Published var connectedPeers: [MCPeerID] = []
}

extension ConnectDevicesSession: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
        log.info("didReceiveInvitationFromPeer \(peerID)")
    }
}

extension ConnectDevicesSession: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        log.error("ServiceBrowser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        connectedPeers.append(peerID)
        print("(Session.connected @@@@@ \(session.connectedPeers)")
        serviceBrowser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        log.info("ServiceBrowser found peer: \(peerID)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
    }
}

extension ConnectDevicesSession: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
    }
   
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let decoder = JSONDecoder()
            let receivedProfile = try decoder.decode(UserProfile.self, from: data)
            
            log.info("Received user profile for: \(receivedProfile.name)")
            
            DispatchQueue.main.async {
                self.updateUserProfile(receivedProfile)
            }
        } catch {
            log.error("Failed to decode received data: \(error)")
            log.info("Received invalid data of \(data.count) bytes")
        }
    }

    // Assuming you have a method to update the user profile
    private func updateUserProfile(_ profile: UserProfile) {
        // Update your app's state with the new profile
        // For example:
        self.userProfile = profile
        // Trigger any necessary UI updates
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }
}
