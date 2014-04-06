-- | Weapons and treasure for LambdaHack.
module Content.ItemKind ( cdefs ) where

import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Common.Effect
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.ItemFeature
import Game.LambdaHack.Common.Msg
import Game.LambdaHack.Content.ItemKind

cdefs :: ContentDef ItemKind
cdefs = ContentDef
  { getSymbol = isymbol
  , getName = iname
  , getFreq = ifreq
  , validate = validateItemKind
  , content =
      [amulet, brassLantern, dart, gem1, gem2, gem3, currency, harpoon, oilLamp, potion1, potion2, potion3, ring, scroll1, scroll2, scroll3, scroll4, sword, wand1, wand2, woodenTorch, fist, foot, tentacle, fragrance, mist_healing, mist_wounding, burningOil1, burningOil2, burningOil3, burningOil4, explosionBlast10, glass_piece, smoke]
  }
amulet,        brassLantern, dart, gem1, gem2, gem3, currency, harpoon, oilLamp, potion1, potion2, potion3, ring, scroll1, scroll2, scroll3, scroll4, sword, wand1, wand2, woodenTorch, fist, foot, tentacle, fragrance, mist_healing, mist_wounding, burningOil1, burningOil2, burningOil3, burningOil4, explosionBlast10, glass_piece, smoke :: ItemKind

gem, potion, scroll, wand :: ItemKind  -- generic templates

amulet = ItemKind
  { isymbol  = '"'
  , iname    = "amulet"
  , ifreq    = [("useful", 6)]
  , iflavour = zipFancy [BrGreen]
  , icount   = 1
  , iverbApply   = "tear down"
  , iverbProject = "cast"
  , iweight  = 30
  , itoThrow = -50  -- not dense enough
  , ifeature = [Cause $ Regeneration (2 * d 3 + dl 10)]
  , idesc    = "A necklace of dried herbs and healing berries."
  }
brassLantern = ItemKind
  { isymbol  = '('
  , iname    = "brass lantern"
  , ifreq    = [("useful", 2)]
  , iflavour = zipPlain [BrWhite]
  , icount   = 1
  , iverbApply   = "burn"
  , iverbProject = "heave"
  , iweight  = 2400
  , itoThrow = -30  -- hard to throw so that it opens and burns
  , ifeature = [Cause $ Burn 4, Explode "burning oil 4"]
  , idesc    = "Very bright and quite heavy brass lantern."
  }
dart = ItemKind
  { isymbol  = '|'
  , iname    = "dart"
  , ifreq    = [("useful", 20)]
  , iflavour = zipPlain [Cyan]
  , icount   = 3 * d 3
  , iverbApply   = "snap"
  , iverbProject = "hurl"
  , iweight  = 50
  , itoThrow = 0  -- a cheap dart
  , ifeature = [Cause $ Hurt (d 2) (d 2 + dl 2)]
  , idesc    = "Little, but sharp and easy to throw with great speed."
  }
gem = ItemKind
  { isymbol  = '*'
  , iname    = "gem"
  , ifreq    = [("treasure", 20)]  -- x3, but rare on shallow levels
  , iflavour = zipPlain brightCol  -- natural, so not fancy
  , icount   = 0
  , iverbApply   = "crush"
  , iverbProject = "toss"
  , iweight  = 50
  , itoThrow = 0
  , ifeature = []
  , idesc    = "Precious, though useless. Worth around 100 gold."
  }
gem1 = gem
  { icount   = dl 1  -- appears on max depth
  }
gem2 = gem
  { icount   = dl 2  -- appears halfway
  }
gem3 = gem
  { icount   = dl 3  -- appears early
  }
currency = ItemKind
  { isymbol  = '$'
  , iname    = "gold piece"
  , ifreq    = [("treasure", 20), ("currency", 1)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 10 * dl 10  -- appears on lvl 2
  , iverbApply   = "grind"
  , iverbProject = "toss"
  , iweight  = 31
  , itoThrow = 0
  , ifeature = []
  , idesc    = "Reliably valuable in every civilized place."
  }
harpoon = ItemKind
  { isymbol  = '|'
  , iname    = "harpoon"
  , ifreq    = [("useful", 25)]
  , iflavour = zipPlain [Brown]
  , icount   = 2 * dl 2
  , iverbApply   = "break up"
  , iverbProject = "hurl"
  , iweight  = 4000
  , itoThrow = 0  -- cheap but deadly
  , ifeature = [Cause $ Hurt (2 * d 2) (d 2 + 2 * dl 2)]
  , idesc    = "A long, well balanced rod, with a cruel, barbed head."
  }
oilLamp = ItemKind
  { isymbol  = '('
  , iname    = "oil lamp"
  , ifreq    = [("useful", 5)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 1
  , iverbApply   = "burn"
  , iverbProject = "lob"
  , iweight  = 1000
  , itoThrow = -30  -- hard not to spill the oil while throwing
  , ifeature = [Cause $ Burn 3, Explode "burning oil 3"]
  , idesc    = "A clay lamp full of plant oil feeding a thick wick."
  }
potion = ItemKind
  { isymbol  = '!'
  , iname    = "potion"
  , ifreq    = [("useful", 10)]
  , iflavour = zipFancy stdCol
  , icount   = 1
  , iverbApply   = "gulp down"
  , iverbProject = "lob"
  , iweight  = 200
  , itoThrow = -50  -- oily, bad grip
  , ifeature = []
  , idesc    = "A flask of bubbly, slightly oily liquid of a suspect color."
  }
potion1 = potion
  { ifeature = [Cause ApplyPerfume, Explode "fragrance"]
  }
potion2 = potion
  { ifeature = [Cause $ Heal 5, Explode "healing mist"]
  }
potion3 = potion
  { ifeature = [Explode "explosion blast 10"]
  }
ring = ItemKind
  { isymbol  = '='
  , iname    = "ring"
  , ifreq    = [("useful", 6)]
  , iflavour = zipPlain [White]
  , icount   = 1
  , iverbApply   = "squeeze down"
  , iverbProject = "toss"
  , iweight  = 15
  , itoThrow = 0
  , ifeature = [Cause $ Steadfastness (d 2 + 2 * dl 2)]
  , idesc    = "Cold, solid to the touch, perfectly round, engraved with the reminder of purpose."
  }
scroll = ItemKind
  { isymbol  = '?'
  , iname    = "scroll"
  , ifreq    = [("useful", 4)]
  , iflavour = zipFancy darkCol  -- arcane and old
  , icount   = 1
  , iverbApply   = "decipher"
  , iverbProject = "lob"
  , iweight  = 50
  , itoThrow = -75  -- bad shape, even rolled up
  , ifeature = []
  , idesc    = "A haphazardly scribbled piece of parchment. May contain directions or a secret call sign."
  }
scroll1 = scroll
  { ifreq    = [("useful", 2)]
  , ifeature = [Cause $ CallFriend 1]
  }
scroll2 = scroll
  { ifeature = [Cause $ Summon 1]
  }
scroll3 = scroll
  { ifeature = [Cause $ Ascend (-1)]
  }
scroll4 = scroll
  { ifreq    = [("useful", 1)]
  , ifeature = [Cause Dominate]
  }
sword = ItemKind
  { isymbol  = ')'
  , iname    = "sword"
  , ifreq    = [("useful", 40)]
  , iflavour = zipPlain [BrCyan]
  , icount   = 1
  , iverbApply   = "hit"
  , iverbProject = "heave"
  , iweight  = 2000
  , itoThrow = -60  -- ensuring it hits with the tip costs speed
  , ifeature = [Cause $ Hurt (5 * d 1) (d 2 + 4 * dl 2)]
  , idesc    = "A standard heavy weapon. Does not penetrate very effectively, but hard to block."
  }
wand = ItemKind
  { isymbol  = '/'
  , iname    = "wand"
  , ifreq    = []  -- TODO: add charges, etc.  -- [("useful", 2)]
  , iflavour = zipFancy brightCol
  , icount   = 1
  , iverbApply   = "snap"
  , iverbProject = "zap"
  , iweight  = 300
  , itoThrow = 25  -- magic
  , ifeature = [Fragile]
  , idesc    = "Buzzing with dazzling light that shines even through appendages that handle it."
  }
wand1 = wand
  { ifeature = ifeature wand ++ [Cause NoEffect]
  }
wand2 = wand
  { ifeature = ifeature wand ++ [Cause NoEffect]
  }
woodenTorch = ItemKind
  { isymbol  = '('
  , iname    = "wooden torch"
  , ifreq    = [("useful", 10)]
  , iflavour = zipPlain [Brown]
  , icount   = d 3
  , iverbApply   = "burn"
  , iverbProject = "fling"
  , iweight  = 1200
  , itoThrow = 0
  , ifeature = [Cause $ Burn 2]
  , idesc    = "A heavy wooden torch, burning with a weak fire."
  }
fist = sword
  { isymbol  = '@'
  , iname    = "fist"
  , ifreq    = [("hth", 1), ("unarmed", 100)]
  , iverbApply   = "punch"
  , iverbProject = "ERROR, please report: iverbProject fist"
  , ifeature = [Cause $ Hurt (5 * d 1) 0]
  , idesc    = ""
  }
foot = sword
  { isymbol  = '@'
  , iname    = "foot"
  , ifreq    = [("hth", 1), ("unarmed", 50)]
  , iverbApply   = "kick"
  , iverbProject = "ERROR, please report: iverbProject foot"
  , ifeature = [Cause $ Hurt (5 * d 1) 0]
  , idesc    = ""
  }
tentacle = sword
  { isymbol  = 'S'
  , iname    = "tentacle"
  , ifreq    = [("hth", 1), ("monstrous", 100)]
  , iverbApply   = "hit"
  , iverbProject = "ERROR, please report: iverbProject tentacle"
  , ifeature = [Cause $ Hurt (5 * d 1) 0]
  , idesc    = ""
  }
fragrance = ItemKind
  { isymbol  = '\''
  , iname    = "fragrance"
  , ifreq    = [("fragrance", 1)]
  , iflavour = zipFancy [BrMagenta]
  , icount   = 10 * d 2
  , iverbApply   = "smell"
  , iverbProject = "exude"
  , iweight  = 1
  , itoThrow = -87  -- the slowest that travels at least 2 steps
  , ifeature = [Cause Impress, Fragile]
  , idesc    = ""
  }
mist_healing = ItemKind
  { isymbol  = '\''
  , iname    = "mist"
  , ifreq    = [("healing mist", 1)]
  , iflavour = zipFancy [White]
  , icount   = 5 * d 2
  , iverbApply   = "inhale"
  , iverbProject = "blow"
  , iweight  = 1
  , itoThrow = -93  -- the slowest that gets anywhere (1 step only)
  , ifeature = [Cause $ Heal 2, Fragile]
  , idesc    = ""
  }
mist_wounding = ItemKind
  { isymbol  = '\''
  , iname    = "mist"
  , ifreq    = [("wounding mist", 1)]
  , iflavour = zipFancy [White]
  , icount   = 5 * d 2
  , iverbApply   = "inhale"
  , iverbProject = "blow"
  , iweight  = 1
  , itoThrow = -93
  , ifeature = [Cause $ Heal (-2), Fragile]
  , idesc    = ""
  }
burningOil1 = burningOil 1
burningOil2 = burningOil 2
burningOil3 = burningOil 3
burningOil4 = burningOil 4
explosionBlast10 = explosionBlast 10
glass_piece = ItemKind  -- when blowing up windows
  { isymbol  = '\''
  , iname    = "glass piece"
  , ifreq    = [("glass piece", 1)]
  , iflavour = zipPlain [BrBlue]
  , icount   = 10 * d 2
  , iverbApply   = "grate"
  , iverbProject = "toss"
  , iweight  = 10
  , itoThrow = 0
  , ifeature = [Cause $ Hurt (d 1) 0, Fragile, Linger 20]
  , idesc    = ""
  }
smoke = ItemKind  -- when stuff burns out
  { isymbol  = '\''
  , iname    = "smoke"
  , ifreq    = [("smoke", 1)]
  , iflavour = zipPlain [BrBlack]
  , icount   = 12 * d 2
  , iverbApply   = "inhale"
  , iverbProject = "blow"
  , iweight  = 1
  , itoThrow = -70
  , ifeature = [Fragile]
  , idesc    = ""
  }

burningOil :: Int -> ItemKind
burningOil n = ItemKind
  { isymbol  = '\''
  , iname    = "burning oil"
  , ifreq    = [("burning oil" <+> tshow n, 1)]
  , iflavour = zipFancy [BrYellow]
  , icount   = intToDice (n * 4) * d 2
  , iverbApply   = "smear"
  , iverbProject = "spit"
  , iweight  = 1
  , itoThrow = min 0 $ n * 7 - 100
  , ifeature = [Cause $ Burn 1, Fragile]
  , idesc    = "Sticky, brightly burning oil."
  }

explosionBlast :: Int -> ItemKind
explosionBlast n = ItemKind
  { isymbol  = '\''
  , iname    = "explosion blast"
  , ifreq    = [("explosion blast" <+> tshow n, 1)]
  , iflavour = zipPlain [BrWhite]
  , icount   = 1 + 2 * d 2  -- strong, but few, so not always hits target
  , iverbApply   = "blast"
  , iverbProject = "give off"
  , iweight  = 1
  , itoThrow = 0
  , ifeature = [Cause $ Burn n, Fragile, Linger 10]
  , idesc    = ""
  }
