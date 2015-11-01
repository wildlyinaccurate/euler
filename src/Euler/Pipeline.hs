{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Parser
import Euler.Chintz (getDependencies)


--build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' -> do
            deps <- getDependencies "./components" (map name (components config')) "js"
            --let deps = getDependencies "./components" (map name (components config')) "js"
            show deps
