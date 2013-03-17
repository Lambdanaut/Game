module Main where

import Graphics.UI.SDL as SDL

main = do
	SDL.init [InitEverything]
	setVideoMode 640 480 32 []
	SDL.setCaption "Game!" "game"
	SDL.quit