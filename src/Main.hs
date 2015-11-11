module Main where

import qualified Data.ByteString as BS
import System.Directory (canonicalizePath)
import System.Environment

import Euler.Component
import Euler.Pipeline

main :: IO ()
main = do
    args <- getArgs

    case length args of
        0 -> BS.getContents >>= buildFromInput
        1 -> BS.readFile (args !! 0) >>= buildFromInput
        otherwise -> putStrLn "Program only takes 0 or 1 arguments"




buildFromInput :: BS.ByteString -> IO ()
buildFromInput input = do
    components <- build input
    mapM_ report components


report :: Component -> IO ()
report c = do
    path <- canonicalizePath $ manifest c
    putStrLn $ "Published configuration to " ++ path
