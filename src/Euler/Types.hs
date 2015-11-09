module Euler.Types where


data Component = Component
    { name :: String
    , template :: String
    , assets :: [AssetMap]
    , manifest :: String
    } deriving (Show)


type AssetMap = (String, [String])
