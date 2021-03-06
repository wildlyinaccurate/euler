{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Euler.Chintz where

import Data.List
import GHC.Generics (Generic)

import qualified Data.ByteString as BS
import System.FilePath

import Data.Aeson (FromJSON, Object)
import qualified Data.HashMap.Strict as HM
import Data.Yaml (decodeEither)
import System.FilePath.Glob

import Euler.Control.Monad.Extra


data Configuration = Configuration
    { name :: String
    , dependencies :: HM.HashMap String [String]
    } deriving (Generic, FromJSON)


getDependencies :: FilePath -> [String] -> String -> IO [FilePath]
getDependencies basePath elements key = do
    expandedElements <- uniqConcatMapM (expandElements basePath) elements
    getDependencies' basePath expandedElements key


-- Won't expand the elements dependencies
getDependencies' :: FilePath -> [String] -> String -> IO [FilePath]
getDependencies' basePath elements key = uniqConcatMapM (elementDepdendencies basePath key) elements


expandElements :: FilePath -> String -> IO [String]
expandElements basePath element = expandElements' basePath [] [element]


expandElements' :: FilePath -> [String] -> [String] -> IO [String]
expandElements' basePath prev [] = return prev
expandElements' basePath prev curr = do
    found <- uniqConcatMapM (elementDepdendencies basePath "elements") curr
    expandElements' basePath (nub $ prev ++ curr ++ found) found


elementDepdendencies :: FilePath -> String -> String -> IO [String]
elementDepdendencies basePath key element = do
    config <- elementConfiguration basePath element

    case parseConfiguration config of
        Left err -> return []

        Right config' -> do
            let deps = HM.lookup key $ dependencies config'

            case deps of
                Nothing -> return []
                Just deps' -> return deps'


elementConfiguration :: FilePath -> String -> IO BS.ByteString
elementConfiguration basePath element = do
    configPath <- glob $ basePath </> "[amo]*" </> element </> element <.> "yaml"
    BS.readFile $ head configPath


elementMustachePath :: FilePath -> String -> IO FilePath
elementMustachePath basePath element = do
    paths <- glob $ basePath </> "[amo]*" </> element </> element <.> "mustache"
    return $ head paths


parseConfiguration :: BS.ByteString -> Either String Configuration
parseConfiguration = decodeEither
