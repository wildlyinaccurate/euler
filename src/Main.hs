module Main where

import qualified Data.ByteString as BS
import System.Directory (canonicalizePath)

import Euler.Types
import Euler.Pipeline

main :: IO ()
main = do
    input <- BS.getContents
    components <- build input

    mapM_ report components


report :: Component -> IO ()
report c = do
    path <- canonicalizePath $ manifest c
    putStrLn $ "Published configuration to " ++ path
