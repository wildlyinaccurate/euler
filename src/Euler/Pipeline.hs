{-# LANGUAGE OverloadedStrings #-}

module Euler.Pipeline where

import Data.ByteString (ByteString)

import Euler.Assets (publishAssets)
import Euler.Chintz (expandElements, getDependencies', elementMustachePath)
import Euler.Control.Monad.Extra
import Euler.Manifest (publishManifest)
import Euler.Parser
import Euler.Component hiding (name)


build :: ByteString -> IO [Component]
build input = do
    case parseConfiguration input of
        Left err -> error $ "Invalid Configuration: " ++ err
        Right config -> mapM processComponent (componentNames config)


componentNames :: Configuration -> [String]
componentNames = (map name) . components


processComponent :: String -> IO Component
processComponent component = do
    let componentsPath = "components"

    expandedElements <- uniqConcatMapM (expandElements componentsPath) [component]
    template <- elementMustachePath componentsPath component

    let getDeps = getDependencies' componentsPath expandedElements
    jsDeps <- getDeps "js"
    cssDeps <- getDeps "css"

    jsAssets <- publishAssets componentsPath jsDeps
    cssAssets <- publishAssets componentsPath cssDeps

    let assets = [("js", jsAssets), ("css", cssAssets)]

    manifest <- publishManifest component template assets

    return $ Component component template assets manifest
