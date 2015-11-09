{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Euler.Manifest where

import System.Directory
import System.FilePath

import GHC.Generics (Generic)

import Data.Aeson
import qualified Data.ByteString.Lazy as BS

import Euler.Types


data Manifest = Manifest
    { template :: String
    , assets :: [Asset]
    } deriving (Generic, ToJSON)


data Asset = Asset
    { assetType :: String
    , url :: String
    } deriving (Generic)


instance ToJSON Asset where
    toJSON a = object
        [ "type" .= assetType a
        , "url" .= url a
        ]


publishManifest :: String -> String -> [AssetMap] -> IO FilePath
publishManifest component template assets = do
    let manifestPath = "manifests" </> component <.> "json"

    createDirectoryIfMissing True (dropFileName manifestPath)
    BS.writeFile manifestPath $ buildManifest template assets

    return manifestPath


buildManifest :: String -> [AssetMap] -> BS.ByteString
buildManifest template assets = encode $ Manifest template (expandAssets assets)


expandAssets :: [AssetMap] -> [Asset]
expandAssets assets = concatMap expandAssetsByType assets


expandAssetsByType :: AssetMap -> [Asset]
expandAssetsByType (assetType, assets) = map (Asset assetType) assets
