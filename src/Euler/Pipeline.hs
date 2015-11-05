{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Assets (publishAssets)
import Euler.Chintz (expandElements, getDependencies')
import Euler.Control.Monad.Extra
import Euler.Parser
import Euler.Types


build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' -> do
            let elements = getComponents config'
            results <- mapM processComponent elements

            return $ show $ results


getComponents :: Configuration -> [String]
getComponents = map name . components


processComponent :: String -> IO Component
processComponent component = do
    let componentsPath = "./components/"
    expandedElements <- uniqConcatMapM (expandElements componentsPath) [component]

    let getDeps = getDependencies' componentsPath expandedElements
    jsDeps <- getDeps "js"
    cssDeps <- getDeps "css"

    jsAssets <- publishAssets componentsPath jsDeps
    cssAssets <- publishAssets componentsPath cssDeps

    let processed = (component, [("js", jsAssets), ("css", cssAssets)])

    return processed
