{-# LANGUAGE TemplateHaskell #-}
module Characters where

import Control.Lens

data Character = 
	Protagonist |
	Goomba |
	Shopkeeper | 
	Default 
	deriving Show

data Combatant = Combatant {
	_gCombatant :: Character
,	_gCombatantName :: String
,	_gCombatantHP :: Int
,	_gCombatantMP :: Int
} deriving Show	
makeLenses ''Combatant

buildCombatant :: Character -> Combatant
buildCombatant _ = Combatant Default "" 10 10

t = (buildCombatant Default)^.gCombatantMP