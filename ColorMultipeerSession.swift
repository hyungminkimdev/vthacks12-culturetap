//
//  DataMultipeerSession.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import MultipeerConnectivity
import os

enum NamedColor: String, CaseIterable {
    case red, green, yellow
}

class ColorMultipeerSession: NSObject, ObservableObject {
    
    // serviceType identifies the service
    // (It must be a unique string up to 15 characters long and may only contain ASCII lowercase letters, numbers, and hyphens).

    @Published var currentColor: NamedColor? = nil
    
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
    
    func send(color: NamedColor) {
        log.info("sendColor: \(String(describing: color)) to \(self.session.connectedPeers.count) peers")
        self.currentColor = color

        if !session.connectedPeers.isEmpty {
//        if !connectedPeers.isEmpty {
            do {
                try session.send(color.rawValue.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
//                try session.send(color.rawValue.data(using: .utf8)!, toPeers: connectedPeers, with: .reliable)

            } catch {
                log.error("Error for sending: \(String(describing: error))")
            }
        }
        else {
            print("Session not found")
            print("Session: \(session)")
        }
    }
    
    
    @Published var connectedPeers: [MCPeerID] = []
}

extension ColorMultipeerSession: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
        log.info("didReceiveInvitationFromPeer \(peerID)")
    }
}

extension ColorMultipeerSession: MCNearbyServiceBrowserDelegate {
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

extension ColorMultipeerSession: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8), let color = NamedColor(rawValue: string) {
            log.info("didReceive color \(string)")
            DispatchQueue.main.async {
                self.currentColor = color
            }
        } else {
            log.info("didReceive invalid value \(data.count) bytes")
        }
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
