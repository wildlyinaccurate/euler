module Main where

import qualified Data.ByteString as BS
import Euler.Pipeline

main :: IO ()
main = do
    input <- BS.getContents
    res <- build input
    putStrLn res
