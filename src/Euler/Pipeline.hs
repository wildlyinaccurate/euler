{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Parser
import Euler.Chintz (getDependencies)


build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' -> do
            let getDeps = getDependencies "./components" (map name (components config'))
            jsDeps <- getDeps "js"
            cssDeps <- getDeps "css"
            return $ show $ jsDeps ++ cssDeps
