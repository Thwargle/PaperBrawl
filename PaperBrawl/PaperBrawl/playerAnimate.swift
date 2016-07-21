//
//  playerAnimate.swift
//  PaperBrawl
//
//  Created by Jonathan Newberry on 7/20/16.
//  Copyright © 2016 Thwargle Games. All rights reserved.
//

import Foundation
import SpriteKit


class playerAnimate {
    
    // sprite names
    let player0 = "runningGuy0"
    let player1 = "runningGuy1"
    let player2 = "runningGuy2"
    let player3 = "runningGuy3"
    let player4 = "runningGuy4"
    
    
    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "Sprites")
    
    
    // individual texture objects
    func playerFunc0() -> SKTexture { return textureAtlas.textureNamed(player0) }
    func playerFunc1() -> SKTexture { return textureAtlas.textureNamed(player1) }
    func playerFunc2() -> SKTexture { return textureAtlas.textureNamed(player2) }
    func playerFunc3() -> SKTexture { return textureAtlas.textureNamed(player3) }
    func playerFunc4() -> SKTexture { return textureAtlas.textureNamed(player4) }
    
    // texture arrays for animations
    func playerTurn() -> [SKTexture] {
        return playerWalk()
    }
    
    func playerWalk() -> [SKTexture] {
        return [
            playerFunc0(),
            playerFunc1(),
            playerFunc2(),
            playerFunc3(),
            playerFunc4()            
        ]
    }
}