//
//  CarrouselView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 19/12/24.
//

import SwiftUI

struct BikesCarrouselView: View {
    @StateObject var bikeVM = BikeViewModel()
    
    @Binding var selectedBike: BikeModel?
    
    @State var currentIndex: Int = 0
    @GestureState var dragOffset: CGFloat = 0
    private let padding: CGFloat = 2
    
    var body: some View {
        switch bikeVM.paginationStatus {
        case .initialLoading:
            SpinnerView()
                .frame(height: 220)
                .onAppear(){
                    Task{
                        await bikeVM.getAllBikes()
                    }
                }
        default:
            GeometryReader { outerView in
                LazyHStack(spacing:0){
                    if(bikeVM.paginationStatus == .success || bikeVM.paginationStatus == .loadingNextPage){
                        ForEach(Array(bikeVM.originalBikes.enumerated()), id: \.element.id) { index, bike in
                            BikeCardView(bike: bike, selectedBike: $selectedBike, currentIndex: currentIndex, index: index)
                                .frame(width: outerView.size.width, height: 250)
                                .padding(.horizontal, padding)
                        }
                    }
                    
                    if(bikeVM.paginationStatus == .loadingNextPage){
                        SpinnerView()
                    }
                    
                    if(bikeVM.paginationStatus == .success && bikeVM.hasNextPage){
                        SpinnerView()
                            .onAppear(){
                                bikeVM.paginationStatus = .loadingNextPage
                                Task{
                                    await bikeVM.getAllBikes()
                                }
                            }
                    }
                }
                .frame(width: outerView.size.width, alignment: .leading)
                .offset(x: -padding - CGFloat(currentIndex)*(outerView.size.width + padding * 2))
                .offset(x: dragOffset)
                .gesture(
                    DragGesture().updating($dragOffset, body: { value, state, transaction in
                        state = value.translation.width
                    }).onEnded({ value in
                        let threshold = outerView.size.width * 0.55
                        var newIndex = Int(-value.translation.width / threshold) + currentIndex
                        newIndex = min(max(newIndex, 0), bikeVM.originalBikes.count - 1)
                        currentIndex = newIndex
                    })
                )
                .scaleEffect(0.7)
            }
            .frame(height: 220)
            .animation(.interpolatingSpring(.bouncy), value: dragOffset)
        }
    }
}

#Preview {
    BikesCarrouselView(selectedBike: .constant(nil))
}
