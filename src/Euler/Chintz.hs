{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Euler.Chintz where

import Data.Text.Internal (Text)
import GHC.Generics (Generic)

import qualified Data.ByteString as BS
import System.FilePath

import Data.Aeson (FromJSON, Object)
import qualified Data.HashMap.Strict as HM
import Data.Yaml (decodeEither)
import System.FilePath.Glob


data Configuration = Configuration
    { name :: String
    , dependencies :: Object
    } deriving (Generic, FromJSON)


getDependencies :: String -> [String] -> Text -> [String]
getDependencies basePath elements key = do
    let allDeps = mapM (elementDepdendencies basePath key) elements
    ["foo", "bar", "lol"]


uhhh basePath elements key = mapM (elementDepdendencies basePath key) elements


elementDepdendencies :: String -> Text -> String -> IO [String]
elementDepdendencies basePath key element = do
    config <- elementConfiguration basePath element

    case parseConfiguration config of
        Left err -> do
            return []

        Right config' -> do
            let deps = HM.lookup key $ dependencies config'

            case deps of
                Nothing -> return []
                Just deps' -> return ["deps'"]


unwrap val = do
    case val of
        Right v -> v


elementConfiguration :: String -> String -> IO BS.ByteString
elementConfiguration basePath element = do
    configPath <- glob $ basePath </> "[amo]*" </> element </> element <.> "yaml"
    BS.readFile $ head configPath


parseConfiguration :: BS.ByteString -> Either String Configuration
parseConfiguration = decodeEither