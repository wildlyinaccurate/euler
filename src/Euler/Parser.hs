{-# LANGUAGE DeriveGeneric #-}

module Euler.Parser where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON)
import Data.ByteString (ByteString)
import Data.Yaml (decodeEither)


data Configuration = Configuration
    { components :: [String]
    } deriving (Generic)


instance FromJSON Configuration


parseConfiguration :: ByteString -> Either String Configuration
parseConfiguration = decodeEither
