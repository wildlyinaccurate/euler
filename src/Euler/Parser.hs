{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Euler.Parser where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON)
import Data.ByteString (ByteString)
import Data.Yaml (decodeEither)


data Configuration = Configuration
    { components :: [ConfigurationComponent]
    } deriving (Generic, FromJSON)


data ConfigurationComponent = ConfigurationComponent
    { name :: String
    , mandatory :: Bool
    } deriving (Generic, FromJSON)


parseConfiguration :: ByteString -> Either String Configuration
parseConfiguration = decodeEither
