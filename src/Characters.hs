{-# LANGUAGE TemplateHaskell #-}
module Characters where

-- Game Libraries
import Config
import Mechanics

-- Haskell Platform Libraries
import System.FilePath

-- External Libraries
import Control.Lens
import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

data Character = 
    Protagonist |
    Shopkeeper | 
    DefaultChar
    deriving Show

showName :: Character -> String
showName DefaultChar = "Default Character"
showName x = show x

data Weapon =
    Hammer
    deriving Show

data Armor =
    Shirt
    deriving Show

data Accessory =
    HappyRing
    deriving Show

data CharacterState =
    Walking |
    Neutral |
    Talking |
    Attacking |
    Defending 
    deriving (Show, Enum)

data Stats = Stats {
    _statsLvl       :: Int
,   _statsHP        :: Int
,   _statsMP        :: Int
,   _statsAttack    :: Int
,   _statsDef       :: Int
,   _statsMgAttack  :: Int
,   _statsMgDef     :: Int
,   _statsWeapon    :: Maybe Weapon
,   _statsArmor     :: Maybe Armor
,   _statsAccessory :: Maybe Accessory
} deriving Show    
makeLenses ''Stats

data Unit = Unit {
    _unitCharacter :: Character
,   _unitName      :: String
,   _unitPos       :: (Int, Int, Int)
,   _unitState     :: CharacterState
,   _unitStatePos  :: Int
,   _unitDirection :: Direction
,   _unitStats     :: Maybe Stats
}
makeLenses ''Unit

buildStats :: Character -> Stats
buildStats Protagonist = Stats 1 25 5 5 2 6 3 Nothing Nothing Nothing 
buildStats x           = Stats 1 10 0 5 2 6 3 Nothing Nothing Nothing 

t = set statsLvl 100 (buildStats DefaultChar)

type Spriteset = [(CharacterState, [SDL.Rect])]

_characterSpriteset :: Character -> Spriteset
_characterSpriteset Protagonist = []
    where spriteW = 100
          spriteH = 100
          states = zip [Walking, Neutral, Attacking] [3, 3, 3]
_characterSpriteset _ = []

buildSpritesetRow :: Int -> Int -> Int -> Int -> [SDL.Rect]
buildSpritesetRow y w h len = map (\x -> Rect (x*w) (y*h) w h) [0..len]

{-
charSprites :: Character -> IO Spriteset
charSprites Protagonist = load $ joinPath [artDir, "sprite_sheet.gif"]
charSprites _ = []
    where load filepath = SDLi.load filepath
-}