module Euler.Manifest where

import System.Directory
import System.FilePath

import Euler.Types


publishManifest :: String -> [AssetMap] -> IO FilePath
publishManifest component assets = do
    let manifestPath = "manifests" </> component <.> "json"

    createDirectoryIfMissing True (dropFileName manifestPath)
    writeFile manifestPath "tee hee"

    return manifestPath
