//
//  ActorController.swift
//  MovieList
//
//  Created by ismet sarı on 29.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class ActorController {

    static let shared = ActorController()

    private var popularActors: [Int: Actor] = [:]

    func getTheActor(_ actorID: Int) -> Actor? {
        return self.popularActors[actorID]
    }

    func addPopularActors(_ newActorList: [Actor]) {

        for actor in newActorList {
            if let theID = actor.id {
                self.popularActors[theID] = actor
            }

        }
    }

    func getPopularActors() -> [Actor] {
        return Array(self.popularActors.values)
    }

}
