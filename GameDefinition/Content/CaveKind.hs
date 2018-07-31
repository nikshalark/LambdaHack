-- | Cave properties.
module Content.CaveKind
  ( content
  ) where

import Prelude ()

import Game.LambdaHack.Common.Prelude

import Data.Ratio

import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Content.CaveKind

content :: [CaveKind]
content =
  [rogue, arena, arena2, laboratory, empty, noise, noise2, shallow2rogue, shallow1rogue, raid, brawl, shootout, escape, zoo, ambush, battle, safari1, safari2, safari3]

rogue,    arena, arena2, laboratory, empty, noise, noise2, shallow2rogue, shallow1rogue, raid, brawl, shootout, escape, zoo, ambush, battle, safari1, safari2, safari3 :: CaveKind

rogue = CaveKind
  { csymbol       = 'R'
  , cname         = "A maze of twisty passages"
  , cfreq         = [ ("default random", 100), ("deep random", 100)
                    , ("caveRogue", 1) ]
  , cXminSize     = 80
  , cYminSize     = 21
  , ccellSize     = DiceXY (2 `d` 4 + 10) 6
  , cminPlaceSize = DiceXY (2 `d` 2 + 4) 5
  , cmaxPlaceSize = DiceXY 16 40
  , cdarkChance   = 1 `d` 54 + 1 `dL` 20
  , cnightChance  = 51  -- always night
  , cauxConnects  = 1%2
  , cmaxVoid      = 1%6
  , cminStairDist = 20
  , cextraStairs  = 1 + 1 `d` 2
  , cdoorChance   = 3%4
  , copenChance   = 1%5
  , chidden       = 7
  , cactorCoeff   = 65  -- the maze requires time to explore
  , cactorFreq    = [("monster", 60), ("animal", 40)]
  , citemNum      = 6 `d` 5 - 4 `dL` 1  -- deeper down quality over quantity
  , citemFreq     = [("common item", 40), ("treasure", 60)]
  , cplaceFreq    = [("rogue", 100)]
  , cpassable     = False
  , cdefTile        = "fillerWall"
  , cdarkCorTile    = "floorCorridorDark"
  , clitCorTile     = "floorCorridorLit"
  , cfillerTile     = "fillerWall"
  , cfenceTileN     = "basic outer fence"
  , cfenceTileE     = "basic outer fence"
  , cfenceTileS     = "basic outer fence"
  , cfenceTileW     = "basic outer fence"
  , cfenceApart     = False
  , clegendDarkTile = "legendDark"
  , clegendLitTile  = "legendLit"
  , cescapeFreq   = []
  , cstairFreq    = [ ("walled staircase", 50), ("open staircase", 50)
                    , ("tiny staircase", 1) ]
  , cdesc         = "Winding tunnels stretch into the dark."
  }  -- no lit corridor alternative, because both lit # and . look bad here
arena = rogue
  { csymbol       = 'A'
  , cname         = "Dusty underground library"
  , cfreq         = [("default random", 40), ("caveArena", 1)]
  , cXminSize     = 50
  , cYminSize     = 21
  , ccellSize     = DiceXY (3 `d` 3 + 17) (1 `d` 3 + 4)
  , cminPlaceSize = DiceXY (2 `d` 2 + 4) 6
  , cmaxPlaceSize = DiceXY 16 12
  , cdarkChance   = 49 + 1 `d` 10  -- almost all rooms dark (1 in 10 lit)
  -- Light is not too deadly, because not many obstructions and so
  -- foes visible from far away and few foes have ranged combat
  -- at shallow depth.
  , cnightChance  = 0  -- always day
  , cauxConnects  = 1
  , cmaxVoid      = 1%8
  , cminStairDist = 15
  , cextraStairs  = 1
  , chidden       = 0
  , cactorCoeff   = 75  -- small open level, don't rush the player
  , cactorFreq    = [("monster", 30), ("animal", 70)]
  , citemNum      = 4 `d` 5  -- few rooms
  , citemFreq     = [("common item", 20), ("treasure", 40), ("any scroll", 40)]
  , cplaceFreq    = [("arena", 100)]
  , cpassable     = True
  , cdefTile      = "arenaSetLit"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  , cstairFreq    = [ ("walled staircase", 20), ("closed staircase", 80)
                    , ("tiny staircase", 1) ]
  , cdesc         = "The shelves groan with dusty books and tattered scrolls."
  }
arena2 = arena
  { cname         = "Smoking rooms"
  , cfreq         = [("deep random", 30)]
  , cdarkChance   = 41 + 1 `d` 10  -- almost all rooms lit (1 in 10 dark)
  -- Trails provide enough light for fun stealth.
  , cnightChance  = 51  -- always night
  , citemNum      = 6 `d` 5  -- rare, so make it exciting
  , citemFreq     = [("common item", 20), ("treasure", 40), ("any vial", 40)]
  , cdefTile      = "arenaSetDark"
  , cdesc         = "Velvet couches exude the strong smell of tobacco."
  }
laboratory = arena2
  { csymbol       = 'L'
  , cname         = "Burnt laboratory"
  , cfreq         = [("deep random", 20), ("caveLaboratory", 1)]
  , cXminSize     = 60
  , cYminSize     = 21
  , ccellSize     = DiceXY (1 `d` 2 + 5) 6
  , cminPlaceSize = DiceXY 7 5
  , cmaxPlaceSize = DiceXY 10 40
  , cdarkChance   = 1 `d` 54 + 1 `dL` 20
      -- most rooms lit, to compensate for corridors
  , cnightChance  = 0  -- always day
  , cauxConnects  = 1%5
  , cmaxVoid      = 1%10
  , cdoorChance   = 1
  , copenChance   = 1%2
  , chidden       = 7
  , citemNum      = 6 `d` 5  -- reward difficulty
  , citemFreq     = [("common item", 20), ("treasure", 40), ("explosive", 40)]
  , cplaceFreq    = [("laboratory", 100)]
  , cpassable     = False
  , cdefTile      = "fillerWall"
  , cdarkCorTile  = "labTrailLit"  -- let lab smoke give off light always
  , clitCorTile   = "labTrailLit"
  , cstairFreq    = [ ("walled staircase", 50), ("open staircase", 50)
                    , ("tiny staircase", 1) ]
  , cdesc         = "Shattered glassware and the sharp scent of spilt chemicals show that something terrible happened here."
  }
empty = rogue
  { csymbol       = 'E'
  , cname         = "Tall cavern"
  , cfreq         = [("caveEmpty", 1)]
  , ccellSize     = DiceXY (2 `d` 10 + 30) 10
  , cminPlaceSize = DiceXY 12 9
  , cmaxPlaceSize = DiceXY 48 32  -- favour large rooms
  , cdarkChance   = 1 `d` 100 + 1 `dL` 100
  , cnightChance  = 0  -- always day
  , cauxConnects  = 3%2
  , cmaxVoid      = 0  -- too few rooms to have void and fog common anyway
  , cminStairDist = 30
  , cextraStairs  = 1
  , cdoorChance   = 0
  , copenChance   = 0
  , chidden       = 0
  , cactorCoeff   = 7
  , cactorFreq    = [("animal", 10), ("immobile animal", 90)]
      -- The healing geysers on lvl 3 act like HP resets. Needed to avoid
      -- cascading failure, if the particular starting conditions were
      -- very hard. Items are not reset, even if they are bad, which provides
      -- enough of a continuity. Gyesers on lvl 3 are not OP and can't be
      -- abused, because they spawn less and less often and also HP doesn't
      -- effectively accumulate over max.
  , citemNum      = 4 `d` 5  -- few rooms and geysers are the boon
  , cplaceFreq    = [("empty", 100)]
  , cpassable     = True
  , cdefTile      = "emptySet"
  , cdarkCorTile  = "floorArenaDark"
  , clitCorTile   = "floorArenaLit"
  , cstairFreq    = [ ("walled staircase", 20), ("closed staircase", 80)
                    , ("tiny staircase", 1) ]
  , cdesc         = "Swirls of warm fog fill the air, the hiss of geysers sounding all around."
  }
noise = rogue
  { csymbol       = 'N'
  , cname         = "Leaky burrowed sediment"
  , cfreq         = [("default random", 10), ("caveNoise", 1)]
  , cXminSize     = 50
  , cYminSize     = 21
  , ccellSize     = DiceXY (3 `d` 5 + 12) 6
  , cminPlaceSize = DiceXY 8 5
  , cmaxPlaceSize = DiceXY 20 20
  , cdarkChance   = 51
  -- Light is deadly, because nowhere to hide and pillars enable spawning
  -- very close to heroes.
  , cnightChance  = 0  -- harder variant, but looks cheerful
  , cauxConnects  = 1%10
  , cmaxVoid      = 1%100
  , cminStairDist = 15
  , cdoorChance   = 1  -- to avoid lit quasi-door tiles
  , chidden       = 0
  , cactorCoeff   = 80  -- the maze requires time to explore; also, small
  , cactorFreq    = [("monster", 80), ("animal", 20)]
  , citemNum      = 6 `d` 5  -- an incentive to explore the labyrinth
  , cpassable     = True
  , cplaceFreq    = [("noise", 100)]
  , cdefTile      = "noiseSet"
  , cfenceApart   = True  -- ensures no cut-off parts from collapsed
  , cdarkCorTile  = "floorArenaDark"
  , clitCorTile   = "floorArenaLit"
  , cstairFreq    = [ ("closed staircase", 50), ("open staircase", 50)
                    , ("tiny staircase", 1) ]
  , cdesc         = "Soon, these passages will be swallowed up by the mud."
  }
noise2 = noise
  { cname         = "Frozen derelict mine"
  , cfreq         = [("caveNoise2", 1)]
  , cnightChance  = 51  -- easier variant, but looks sinister
  , citemNum      = 11 `d` 5  -- an incentive to explore the final labyrinth
  , citemFreq     = [ ("common item", 20), ("treasure", 60)
                    , ("explosive", 20) ]
  , cplaceFreq    = [("noise", 1), ("mine", 99)]
  , cstairFreq    = [ ("gated closed staircase", 50)
                    , ("gated open staircase", 50)
                    , ("gated tiny staircase", 1) ]
  , cdesc         = "Pillars of shining ice create a frozen labyrinth."
  }
shallow2rogue = rogue
  { cfreq         = [("shallow random 2", 100)]
  , cXminSize     = 60
  , cYminSize     = 21
  , cextraStairs  = 1  -- ensure heroes meet initial monsters and their loot
  , cdesc         = "The snorts and grunts of savage beasts can be clearly heard."
  }
shallow1rogue = shallow2rogue
  { csymbol       = 'B'
  , cname         = "Cave entrance"
  , cfreq         = [("outermost", 100)]
  , cXminSize     = 40
  , cYminSize     = 21
  , cdarkChance   = 0  -- all rooms lit, for a gentle start
  , cminStairDist = 10
  , cextraStairs  = 1
  , cactorCoeff   = 80  -- already animals start there; also, pity on the noob
  , cactorFreq    = filter ((/= "monster") . fst) $ cactorFreq rogue
  , citemNum      = 6 `d` 5  -- lure them in with loot
  , citemFreq     = filter ((/= "treasure") . fst) $ citemFreq rogue
  , cescapeFreq   = [("escape up", 1)]
  , cdesc         = "This close to the surface, the sunlight still illuminates the dungeon."
  }
raid = rogue
  { csymbol       = 'T'
  , cname         = "Typing den"
  , cfreq         = [("caveRaid", 1)]
  , cXminSize     = 50
  , cYminSize     = 21
  , ccellSize     = DiceXY (2 `d` 4 + 6) 6
  , cminPlaceSize = DiceXY (2 `d` 2 + 4) 5
  , cmaxPlaceSize = DiceXY 16 20
  , cdarkChance   = 0  -- all rooms lit, for a gentle start
  , cmaxVoid      = 1%10
  , cextraStairs  = 0
  , cactorCoeff   = 250  -- deep level with no kit, so slow spawning
  , cactorFreq    = [("animal", 100)]
  , citemNum      = 6 `d` 6  -- just one level, hard enemies, treasure
  , citemFreq     = [("common item", 100), ("currency", 500)]
  , cescapeFreq   = [("escape up", 1)]
  , cstairFreq    = []
  , cdesc         = ""
  }
brawl = rogue  -- many random solid tiles, to break LOS, since it's a day
               -- and this scenario is not focused on ranged combat;
               -- also, sanctuaries against missiles in shadow under trees
  { csymbol       = 'b'
  , cname         = "Sunny woodland"
  , cfreq         = [("caveBrawl", 1)]
  , cXminSize     = 60
  , cYminSize     = 21
  , ccellSize     = DiceXY (2 `d` 5 + 8) 6
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 7 5
  , cdarkChance   = 51
  , cnightChance  = 0
  , cdoorChance   = 1
  , copenChance   = 0
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 5 `d` 6
  , citemFreq     = [("common item", 100)]
  , cplaceFreq    = [("brawl", 50), ("laboratory", 50)]
  , cpassable     = True
  , cdefTile      = "brawlSetLit"
  , cdarkCorTile  = "floorArenaLit"
  , clitCorTile   = "floorArenaLit"
  , cstairFreq    = []
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cdesc         = "Sunlight falls through the trees and dapples on the ground."
  }
shootout = rogue  -- a scenario with strong missiles;
                  -- few solid tiles, but only translucent tiles or walkable
                  -- opaque tiles, to make scouting and sniping more interesting
                  -- and to avoid obstructing view too much, since this
                  -- scenario is about ranged combat at long range
  { csymbol       = 'S'
  , cname         = "Misty meadow"
  , cfreq         = [("caveShootout", 1)]
  , ccellSize     = DiceXY (1 `d` 2 + 8) 6
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 3 4
  , cdarkChance   = 51
  , cnightChance  = 0
  , cauxConnects  = 1%10
  , cdoorChance   = 1
  , copenChance   = 0
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 5 `d` 16
                      -- less items in inventory, more to be picked up,
                      -- to reward explorer and aggressor and punish camper
  , citemFreq     = [ ("common item", 30)
                    , ("any arrow", 400), ("harpoon", 300), ("explosive", 50) ]
                      -- Many consumable buffs are needed in symmetric maps
                      -- so that aggressor prepares them in advance and camper
                      -- needs to waste initial turns to buff for the defence.
  , cplaceFreq    = [("shootout", 100)]
  , cpassable     = True
  , cdefTile      = "shootoutSetLit"
  , cdarkCorTile  = "floorArenaLit"
  , clitCorTile   = "floorArenaLit"
  , cstairFreq    = []
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cdesc         = ""
  }
escape = rogue  -- a scenario with weak missiles, because heroes don't depend
                -- on them; dark, so solid obstacles are to hide from missiles,
                -- not view; obstacles are not lit, to frustrate the AI;
                -- lots of small lights to cross, to have some risks
  { csymbol       = 'E'
  , cname         = "Metropolitan park at dusk"  -- "night" didn't fit
  , cfreq         = [("caveEscape", 1)]
  , ccellSize     = DiceXY (1 `d` 3 + 7) 6
  , cminPlaceSize = DiceXY 5 3
  , cmaxPlaceSize = DiceXY 9 9  -- bias towards larger lamp areas
  , cdarkChance   = 51  -- colonnade rooms should always be dark
  , cnightChance  = 51  -- always night
  , cauxConnects  = 2
  , cmaxVoid      = 1%100
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 6 `d` 8
  , citemFreq     = [ ("common item", 30), ("gem", 150)
                    , ("weak arrow", 500), ("harpoon", 400)
                    , ("explosive", 100) ]
  , cplaceFreq    = [("escape", 100)]
  , cpassable     = True
  , cdefTile      = "escapeSetDark"  -- different tiles, not burning yet
  , cdarkCorTile  = "alarmingTrailLit"  -- let trails give off light
  , clitCorTile   = "alarmingTrailLit"
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cescapeFreq   = [("escape outdoor down", 1)]
  , cstairFreq    = []
  , cdesc         = ""
  }
zoo = rogue  -- few lights and many solids, to help the less numerous heroes
  { csymbol       = 'Z'
  , cname         = "Menagerie in flames"
  , cfreq         = [("caveZoo", 1)]
  , ccellSize     = DiceXY (1 `d` 3 + 7) 6
  , cminPlaceSize = DiceXY 4 4
  , cmaxPlaceSize = DiceXY 12 5
  , cdarkChance   = 51  -- always dark rooms
  , cnightChance  = 51  -- always night
  , cauxConnects  = 1%4
  , cmaxVoid      = 1%20
  , cdoorChance   = 7%10
  , copenChance   = 9%10
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 7 `d` 8
  , citemFreq     = [("common item", 100), ("light source", 1000)]
  , cplaceFreq    = [("zoo", 50)]
  , cpassable     = True
  , cdefTile      = "zooSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  , cstairFreq    = []
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cdesc         = ""
  }
ambush = rogue  -- a scenario with strong missiles;
                -- dark, so solid obstacles are to hide from missiles,
                -- not view, and they are all lit, because stopped missiles
                -- are frustrating, while a few LOS-only obstacles are not lit;
                -- lots of small lights to cross, to give a chance to snipe;
                -- a crucial difference wrt shootout is that trajectories
                -- of missiles are usually not seen, so enemy can't be guessed;
                -- camping doesn't pay off, because enemies can sneak and only
                -- active scouting, throwing flares and shooting discovers them
  { csymbol       = 'M'
  , cname         = "Burning metropolitan park"
  , cfreq         = [("caveAmbush", 1)]
  , ccellSize     = DiceXY (1 `d` 4 + 7) 6
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 9 9  -- bias towards larger lamp areas
  , cdarkChance   = 51  -- colonnade rooms should always be dark
  , cnightChance  = 51  -- always night
  , cauxConnects  = 3%2
  , cmaxVoid      = 1%20
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 5 `d` 8
  , citemFreq     = [ ("common item", 30)
                    , ("any arrow", 400), ("harpoon", 300), ("explosive", 50) ]
  , cplaceFreq    = [("ambush", 100)]
  , cpassable     = True
  , cdefTile      = "ambushSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  , cstairFreq    = []
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cdesc         = ""
  }
battle = rogue  -- few lights and many solids, to help the less numerous heroes
  { csymbol       = 'B'
  , cname         = "Old battle ground"
  , cfreq         = [("caveBattle", 1)]
  , ccellSize     = DiceXY (5 `d` 3 + 11) 6  -- cfenceApart results in 2 rows
  , cminPlaceSize = DiceXY 4 4
  , cmaxPlaceSize = DiceXY 9 7
  , cdarkChance   = 0
  , cnightChance  = 51  -- always night
  , cauxConnects  = 1%4
  , cmaxVoid      = 1%20
  , cdoorChance   = 2%10
  , copenChance   = 9%10
  , cextraStairs  = 0
  , chidden       = 0
  , cactorFreq    = []
  , citemNum      = 5 `d` 8
  , citemFreq     = [("common item", 100), ("light source", 200)]
  , cplaceFreq    = [("battle", 50), ("rogue", 50)]
  , cpassable     = True
  , cdefTile      = "battleSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  , cfenceTileN   = "outdoor outer fence"
  , cfenceTileE   = "outdoor outer fence"
  , cfenceTileS   = "outdoor outer fence"
  , cfenceTileW   = "outdoor outer fence"
  , cfenceApart   = True  -- ensures no cut-off parts from collapsed
  , cstairFreq    = []
  , cdesc         = ""
  }
safari1 = brawl
  { cname         = "Hunam habitat"
  , cfreq         = [("caveSafari1", 1)]
  , cminPlaceSize = DiceXY 5 3
  , cextraStairs  = 1
  , cstairFreq    = [ ("outdoor walled staircase", 20)
                    , ("outdoor closed staircase", 80)
                    , ("outdoor tiny staircase", 1) ]
  , cdesc         = "\"Act 1. Hunams scavenge in a forest in their usual disgusting way.\""
  }
safari2 = ambush  -- lamps instead of trees, but ok, it's only a simulation
  { cname         = "Deep into the jungle"
  , cfreq         = [("caveSafari2", 1)]
  , cminPlaceSize = DiceXY 5 3
  , cextraStairs  = 1
  , cstairFreq    = [ ("outdoor walled staircase", 20)
                    , ("outdoor closed staircase", 80)
                    , ("outdoor tiny staircase", 1) ]
  , cdesc         = "\"Act 2. In the dark pure heart of the jungle noble animals roam freely.\""
  }
safari3 = zoo  -- glass rooms, but ok, it's only a simulation
  { cname         = "Jungle in flames"
  , cfreq         = [("caveSafari3", 1)]
  , cminPlaceSize = DiceXY 5 4
  , cescapeFreq   = [("escape outdoor down", 1)]
  , cextraStairs  = 1
  , cstairFreq    = [ ("outdoor walled staircase", 20)
                    , ("outdoor closed staircase", 80)
                    , ("outdoor tiny staircase", 1) ]
  , cdesc         = "\"Act 3. Jealous hunams set jungle on fire and flee.\""
  }
