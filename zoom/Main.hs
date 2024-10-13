import System.Process
import Data.String
import Prelude hiding (lines)
import System.Environment (getArgs)
import Data.Maybe (listToMaybe)

zoom :: Float -> IO String
zoom factor = readProcess "hyprctl" ["keyword", "cursor:zoom_factor", show factor] ""

getCurrent :: IO Float
getCurrent = read.dropWhile (/= ' ').head.lines <$> readProcess "hyprctl" ["getoption", "cursor:zoom_factor"] ""

actCurrent :: String -> Float -> IO String
actCurrent "in" current = zoom $ current + 0.5
actCurrent "out" current | current > 1.0 = zoom $ current - 0.5
actCurrent _ current = zoom 1.0 

act :: String -> IO String
act arg = do
    current <- getCurrent
    actCurrent arg current


main :: IO String
main = do
    arg <- listToMaybe <$> getArgs
    case arg of 
        Just arg -> act arg
        Nothing -> act ""
