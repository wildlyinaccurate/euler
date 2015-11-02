{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Parser
import Euler.Chintz (expandElements, getDependencies', uniqConcatMapM)


build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' -> do
            let base = "./components"
            let elements = (map name (components config'))
            expandedElements <- uniqConcatMapM (expandElements base) elements

            let getDeps = getDependencies' base expandedElements
            jsDeps <- getDeps "js"
            cssDeps <- getDeps "css"

            return $ show $ jsDeps ++ cssDeps
