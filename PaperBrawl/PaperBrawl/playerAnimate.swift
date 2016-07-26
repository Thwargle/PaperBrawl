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

class pencilManAnimate {
    // sprite names
    let player1 = "Running1"
    let player2 = "Running2"
    let player3 = "Running3"
    let player4 = "Running4"
    let player5 = "Running5"
    let player6 = "Running6"
    let player7 = "Running7"
    let player8 = "Jumping1"
    let player9 = "Jumping2"
    let player10 = "Standing1"
    
    
    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "PencilMan")
    
    
    // individual texture objects
    func playerFunc1() -> SKTexture { return textureAtlas.textureNamed(player1) }
    func playerFunc2() -> SKTexture { return textureAtlas.textureNamed(player2) }
    func playerFunc3() -> SKTexture { return textureAtlas.textureNamed(player3) }
    func playerFunc4() -> SKTexture { return textureAtlas.textureNamed(player4) }
    func playerFunc5() -> SKTexture { return textureAtlas.textureNamed(player5) }
    func playerFunc6() -> SKTexture { return textureAtlas.textureNamed(player6) }
    func playerFunc7() -> SKTexture { return textureAtlas.textureNamed(player7) }
    func playerFunc8() -> SKTexture { return textureAtlas.textureNamed(player8) }
    func playerFunc9() -> SKTexture { return textureAtlas.textureNamed(player9) }
    func playerFunc10() -> SKTexture { return textureAtlas.textureNamed(player10) }
    
    
    // texture arrays for animations
    func pencilManStand() -> [SKTexture] {
        return [playerFunc10()]
    }
    
    func pencilManTurn() -> [SKTexture] {
        return pencilManWalk()
    }
    
    func pencilManWalk() -> [SKTexture] {
        return [
            playerFunc1(),
            playerFunc2(),
            playerFunc3(),
            playerFunc4(),
            playerFunc5(),
            playerFunc6(),
            playerFunc7()
        ]
    }
    
    func pencilManJump()-> [SKTexture] {
        return [
            playerFunc8(),
            playerFunc9(),
            playerFunc9(),
            playerFunc9(),
            playerFunc9()
        ]
    }
    
}
class pencilGirlAnimate {
    // sprite names
    let pencilGirl1 = "Running1"
    let pencilGirl2 = "Running2"
    let pencilGirl3 = "Running3"
    let pencilGirl4 = "Running4"
    let pencilGirl5 = "Running5"
    let pencilGirl6 = "Running6"
    let pencilGirl7 = "Running7"
    let pencilGirl8 = "Jumping1"
    let pencilGirl9 = "Jumping2"
    let pencilGirl10 = "Standing1"
    
    
    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "PencilGirl")
    
    
    // individual texture objects
    func pencilGirlFunc1() -> SKTexture { return textureAtlas.textureNamed(pencilGirl1) }
    func pencilGirlFunc2() -> SKTexture { return textureAtlas.textureNamed(pencilGirl2) }
    func pencilGirlFunc3() -> SKTexture { return textureAtlas.textureNamed(pencilGirl3) }
    func pencilGirlFunc4() -> SKTexture { return textureAtlas.textureNamed(pencilGirl4) }
    func pencilGirlFunc5() -> SKTexture { return textureAtlas.textureNamed(pencilGirl5) }
    func pencilGirlFunc6() -> SKTexture { return textureAtlas.textureNamed(pencilGirl6) }
    func pencilGirlFunc7() -> SKTexture { return textureAtlas.textureNamed(pencilGirl7) }
    func pencilGirlFunc8() -> SKTexture { return textureAtlas.textureNamed(pencilGirl8) }
    func pencilGirlFunc9() -> SKTexture { return textureAtlas.textureNamed(pencilGirl9) }
    func pencilGirlFunc10() -> SKTexture { return textureAtlas.textureNamed(pencilGirl10) }
    
    
    // texture arrays for animations
    func pencilManStand() -> [SKTexture] {
        return [pencilGirlFunc10()]
    }
    
    func pencilManTurn() -> [SKTexture] {
        return pencilManWalk()
    }
    
    func pencilManWalk() -> [SKTexture] {
        return [
            pencilGirlFunc1(),
            pencilGirlFunc2(),
            pencilGirlFunc3(),
            pencilGirlFunc4(),
            pencilGirlFunc5(),
            pencilGirlFunc6(),
            pencilGirlFunc7()
        ]
    }
    
    func pencilManJump()-> [SKTexture] {
        return [
            pencilGirlFunc8(),
            pencilGirlFunc9(),
            pencilGirlFunc9(),
            pencilGirlFunc9(),
            pencilGirlFunc9()
        ]
    }
    
}
