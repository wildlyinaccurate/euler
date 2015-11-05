{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Assets (publishAssets)
import Euler.Chintz (expandElements, getDependencies')
import Euler.Control.Monad.Extra
import Euler.Parser


build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' -> do
            let componentsPath = "./components/"
            let elements = getComponents config'
            expandedElements <- uniqConcatMapM (expandElements componentsPath) elements

            let getDeps = getDependencies' componentsPath expandedElements
            jsDeps <- getDeps "js"
            cssDeps <- getDeps "css"

            jsAssets <- publishAssets componentsPath jsDeps
            cssAssets <- publishAssets componentsPath cssDeps

            return $ show $ jsAssets ++ cssDeps


getComponents :: Configuration -> [String]
getComponents = map name . components
