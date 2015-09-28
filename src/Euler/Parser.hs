{-# LANGUAGE DeriveGeneric #-}

module Euler.Parser where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON)
import Data.ByteString (ByteString)
import Data.Yaml (decodeEither)


data Configuration = Configuration
    { components :: [Component]
    } deriving (Generic)


data Component = Component
    { name :: String
    , source :: String
    , source_params :: Maybe [Parameter]
    , limit :: Maybe Int
    } deriving (Generic)


type Parameter = (String, String)


instance FromJSON Configuration
instance FromJSON Component


parseConfiguration :: ByteString -> Either String Configuration
parseConfiguration = decodeEither
