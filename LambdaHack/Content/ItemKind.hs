-- | Weapons and treasure for LambdaHack.
module Content.ItemKind ( cdefs ) where

import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Effect
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.Random
import Game.LambdaHack.Content.ItemKind

cdefs :: ContentDef ItemKind
cdefs = ContentDef
  { getSymbol = isymbol
  , getName = iname
  , getFreq = ifreq
  , validate = ivalidate
  , content =
      [amulet, dart, gem1, gem2, gem3, currency, harpoon, potion1, potion2, potion3, ring, scroll1, scroll2, scroll3, sword, wand1, wand2, fist, foot, tentacle, shrapnel]
  }
amulet,        dart, gem1, gem2, gem3, currency, harpoon, potion1, potion2, potion3, ring, scroll1, scroll2, scroll3, sword, wand1, wand2, fist, foot, tentacle, shrapnel :: ItemKind

gem, potion, scroll, wand :: ItemKind  -- generic templates

-- castDeep (aDb, xDy) = castDice aDb + (lvl - 1) * castDice xDy / (depth - 1)

amulet = ItemKind
  { isymbol  = '"'
  , iname    = "amulet"
  , ifreq    = [("useful", 6)]
  , iflavour = zipFancy [BrGreen]
  , ieffect  = Regeneration (rollDeep (2, 3) (1, 10))
  , icount   = intToDeep 1
  , iverbApply   = "tear down"
  , iverbProject = "cast"
  , iweight  = 30
  , itoThrow = -50  -- not dense enough
  , ifeature = []
  }
dart = ItemKind
  { isymbol  = '|'
  , iname    = "dart"
  , ifreq    = [("useful", 20)]
  , iflavour = zipPlain [Cyan]
  , ieffect  = Hurt (rollDice 1 1) (rollDeep (1, 2) (1, 2))
  , icount   = rollDeep (3, 3) (0, 0)
  , iverbApply   = "snap"
  , iverbProject = "hurl"
  , iweight  = 50
  , itoThrow = 0  -- a cheap dart
  , ifeature = []
  }
gem = ItemKind
  { isymbol  = '*'
  , iname    = "gem"
  , ifreq    = [("treasure", 20)]  -- x3, but rare on shallow levels
  , iflavour = zipPlain brightCol  -- natural, so not fancy
  , ieffect  = NoEffect
  , icount   = intToDeep 0
  , iverbApply   = "crush"
  , iverbProject = "toss"
  , iweight  = 50
  , itoThrow = 0
  , ifeature = []
  }
gem1 = gem
  { icount   = rollDeep (0, 0) (1, 1)  -- appears on max depth
  }
gem2 = gem
  { icount   = rollDeep (0, 0) (1, 2)  -- appears halfway
  }
gem3 = gem
  { icount   = rollDeep (0, 0) (1, 3)  -- appears early
  }
currency = ItemKind
  { isymbol  = '$'
  , iname    = "gold piece"
  , ifreq    = [("treasure", 20), ("currency", 1)]
  , iflavour = zipPlain [BrYellow]
  , ieffect  = NoEffect
  , icount   = rollDeep (0, 0) (10, 10)  -- appears on lvl 2
  , iverbApply   = "grind"
  , iverbProject = "toss"
  , iweight  = 31
  , itoThrow = 0
  , ifeature = []
  }
harpoon = ItemKind
  { isymbol  = '|'
  , iname    = "harpoon"
  , ifreq    = [("useful", 25)]
  , iflavour = zipPlain [Brown]
  , ieffect  = Hurt (rollDice 1 2) (rollDeep (1, 2) (2, 2))
  , icount   = rollDeep (0, 0) (2, 2)
  , iverbApply   = "break up"
  , iverbProject = "hurl"
  , iweight  = 4000
  , itoThrow = 0  -- cheap but deadly
  , ifeature = []
  }
potion = ItemKind
  { isymbol  = '!'
  , iname    = "potion"
  , ifreq    = [("useful", 15)]
  , iflavour = zipFancy stdCol
  , ieffect  = NoEffect
  , icount   = intToDeep 1
  , iverbApply   = "gulp down"
  , iverbProject = "lob"
  , iweight  = 200
  , itoThrow = -50  -- oily, bad grip
  , ifeature = []
  }
potion1 = potion
  { ifreq    = [("useful", 5)]
  , ieffect  = ApplyPerfume
  }
potion2 = potion
  { ieffect  = Heal 5
  }
potion3 = potion
  { ifreq    = [("useful", 5)]
  , ieffect  = Heal (-5)
  }
ring = ItemKind
  { isymbol  = '='
  , iname    = "ring"
  , ifreq    = []  -- [("useful", 10)]  -- TODO: make it useful
  , iflavour = zipPlain [White]
  , ieffect  = Searching (rollDeep (1, 6) (3, 2))
  , icount   = intToDeep 1
  , iverbApply   = "squeeze down"
  , iverbProject = "toss"
  , iweight  = 15
  , itoThrow = 0
  , ifeature = []
  }
scroll = ItemKind
  { isymbol  = '?'
  , iname    = "scroll"
  , ifreq    = [("useful", 4)]
  , iflavour = zipFancy darkCol  -- arcane and old
  , ieffect  = NoEffect
  , icount   = intToDeep 1
  , iverbApply   = "decipher"
  , iverbProject = "lob"
  , iweight  = 50
  , itoThrow = -75  -- bad shape, even rolled up
  , ifeature = []
  }
scroll1 = scroll
  { ieffect  = CallFriend 1
  , ifreq    = [("useful", 2)]
  }
scroll2 = scroll
  { ieffect  = Summon 1
  }
scroll3 = scroll
  { ieffect  = Ascend (-1)
  }
sword = ItemKind
  { isymbol  = ')'
  , iname    = "sword"
  , ifreq    = [("useful", 40)]
  , iflavour = zipPlain [BrCyan]
  , ieffect  = Hurt (rollDice 3 1) (rollDeep (1, 2) (4, 2))
  , icount   = intToDeep 1
  , iverbApply   = "hit"
  , iverbProject = "heave"
  , iweight  = 2000
  , itoThrow = -50  -- ensuring it hits with the tip costs speed
  , ifeature = []
  }
wand = ItemKind
  { isymbol  = '/'
  , iname    = "wand"
  , ifreq    = [("useful", 10)]
  , iflavour = zipFancy brightCol
  , ieffect  = NoEffect
  , icount   = intToDeep 1
  , iverbApply   = "snap"
  , iverbProject = "zap"
  , iweight  = 300
  , itoThrow = 25  -- magic
  , ifeature = []
  }
wand1 = wand
  { ieffect  = Dominate
  }
wand2 = wand
  { ifreq    = [("useful", 3)]
  , ieffect  = Heal (-25)
  }
fist = sword
  { isymbol  = '@'
  , iname    = "fist"
  , ifreq    = [("hth", 1), ("unarmed", 100)]
  , ieffect  = Hurt (rollDice 3 1) (intToDeep 0)
  , iverbApply   = "punch"
  , iverbProject = "ERROR, please report: iverbProject fist"
  }
foot = sword
  { isymbol  = '@'
  , iname    = "foot"
  , ifreq    = [("hth", 1), ("unarmed", 50)]
  , ieffect  = Hurt (rollDice 3 1) (intToDeep 0)
  , iverbApply   = "kick"
  , iverbProject = "ERROR, please report: iverbProject foot"
  }
tentacle = sword
  { isymbol  = 'S'
  , iname    = "tentacle"
  , ifreq    = [("hth", 1), ("monstrous", 100)]
  , ieffect  = Hurt (rollDice 3 1) (intToDeep 0)
  , iverbApply   = "hit"
  , iverbProject = "ERROR, please report: iverbProject tentacle"
  }
shrapnel = ItemKind
  { isymbol  = '\''
  , iname    = "shrapnel"
  , ifreq    = [("shrapnel", 1)]
  , iflavour = zipPlain [Red]
  , ieffect  = Hurt (rollDice 3 1) (intToDeep 0)
  , icount   = rollDeep (20, 2) (0, 0)
  , iverbApply   = "grate"
  , iverbProject = "toss"
  , iweight  = 10
  , itoThrow = 0
  , ifeature = []
  }
