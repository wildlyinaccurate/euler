module Euler.Assets where

import System.Directory
import System.FilePath

import Euler.Control.Monad.Extra


publishAssets :: String -> [String] -> IO [String]
publishAssets componentsPath origins = mapM (publishAsset componentsPath) origins


publishAsset :: String -> String -> IO String
publishAsset componentsPath origin = do
    let originPath = componentsPath </> origin
    let publishedPath = "assets" </> origin

    createDirectoryIfMissing True (dropFileName publishedPath)
    copyFile originPath publishedPath

    return publishedPath
