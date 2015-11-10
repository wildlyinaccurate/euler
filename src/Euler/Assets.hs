module Euler.Assets where

import System.Directory
import System.FilePath


publishAssets :: FilePath -> [String] -> IO [FilePath]
publishAssets componentsPath origins = mapM (publishAsset componentsPath) origins


publishAsset :: FilePath -> String -> IO FilePath
publishAsset componentsPath origin = do
    let originPath = componentsPath </> origin
    let publishedPath = "assets" </> origin

    createDirectoryIfMissing True (dropFileName publishedPath)
    copyFile originPath publishedPath

    return publishedPath
