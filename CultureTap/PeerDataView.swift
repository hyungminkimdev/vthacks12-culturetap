//
//  PeerDataView.swift
//  CultureTap
//
//  Created by Harditya Sarvaiya on 9/15/24.
//

import SwiftUI
import MapKit

struct PeerDataView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // Initial focus on Seoul
            span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0) // Larger span to show both cities
        )

        let seoulCoordinates = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
        let washingtonDCCoordinates = CLLocationCoordinate2D(latitude: 38.8951, longitude: -77.0364)
        
    var body: some View {
        ScrollView() {
            Spacer()
                .frame(height: 30)
            
            VStack(alignment: .leading) {
                Text("Say 'Hi' to Hyunmin in their language.")
                    .padding()
                    .font(.title3)
                
                RoundedRectangle(cornerRadius: 15)
                    .padding()
                    .foregroundStyle(Color.black)
                    .frame(height: 150)
                    .overlay{
                        VStack{
                            Text("An-nyeong-ha-sae-yo, Hyungmin")
                            Text("Man-na-seo-ban-ga-wuo-yo")
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Distance between us: ")
                        .font(.title2)
                    Text("4267mi")
                        .font(.largeTitle)
                }
                .padding(.horizontal)
                
                
                Map(coordinateRegion: $region, annotationItems: [seoulCoordinates, washingtonDCCoordinates]) { location in
                                MapAnnotation(coordinate: location) {
                                    VStack {
                                        Image(systemName: "mappin.circle.fill")
                                            .resizable()
                                            .foregroundColor(.red)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                            .frame(height: 300)
                            .cornerRadius(15)
                            .padding(.horizontal)
                
                HStack {
                    Button("Show Washington, DC") {
                        region.center = washingtonDCCoordinates
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button("Show Seoul") {
                        region.center = seoulCoordinates
                    }
                    .padding()
                }
                
                Spacer()
                
                Text("Let's get to know each other !")
                    .font(.title2)
                    .padding()
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.black)
                    .frame(height: 200)
                    .overlay{
                        VStack(alignment: .leading){
                            Text("His name is <Hyungmin>")
                            Text("He is <28> years old")
                            Text("He loves <surfing and playing basketball>")
                            Text("(Fun Facts) His favourite player is dirk nowitzki. His age in korean is 30")
                        }
                        .padding()
                    }
            }
            .foregroundStyle(Color.white)
            
            Spacer()
            
            Button(action: {
                print("hi")
            }) {
                Text("Take a quiz on them")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.keyColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.background
                .ignoresSafeArea()
        }
    }
}
struct CLLocationCoordinate2DIdentifiable: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

// Create an array of coordinates for annotation items
extension CLLocationCoordinate2D: Identifiable {
    public var id: UUID { UUID() }
}

#Preview {
    PeerDataView()
}
