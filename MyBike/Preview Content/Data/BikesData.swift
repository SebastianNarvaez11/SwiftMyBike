//
//  BikesData.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 19/12/24.
//

import Foundation

let bikeModels: [BikeModel] = [
    BikeModel(
        id: "1",
        model: "Thunderbolt",
        year: 2023,
        signedUrl: nil,
        photo1: "thunderbolt_1.jpg",
        photo2: "thunderbolt_2.jpg",
        photo3: "thunderbolt_3.jpg",
        brand: BrandModel(id: "1", name: "Rocky Mountain")
    ),
    BikeModel(
        id: "2",
        model: "Fuel EX",
        year: 2022,
        signedUrl: nil,
        
        photo1: "fuel_ex_1.jpg",
        photo2: "fuel_ex_2.jpg",
        photo3: "fuel_ex_3.jpg",
        brand: BrandModel(id: "2", name: "Trek")
    ),
    BikeModel(
        id: "3",
        model: "Stumpjumper",
        year: 2023,
        signedUrl: nil,
        
        photo1: "stumpjumper_1.jpg",
        photo2: nil,
        photo3: nil,
        brand: BrandModel(id: "3", name: "Specialized")
    ),
    BikeModel(
        id: "4",
        model: "Spectral",
        year: 2021,
        signedUrl: nil,
        
        photo1: "spectral_1.jpg",
        photo2: "spectral_2.jpg",
        photo3: nil,
        brand: BrandModel(id: "4", name: "Canyon")
    ),
    BikeModel(
        id: "5",
        model: "SB140",
        year: 2023,
        signedUrl: nil,
        
        photo1: "sb140_1.jpg",
        photo2: "sb140_2.jpg",
        photo3: "sb140_3.jpg",
        brand: BrandModel(id: "5", name: "Yeti")
    ),
    BikeModel(
        id: "6",
        model: "Slash",
        year: 2022,
        signedUrl: nil,
        
        photo1: nil,
        photo2: nil,
        photo3: nil,
        brand: BrandModel(id: "2", name: "Trek")
    )
]

