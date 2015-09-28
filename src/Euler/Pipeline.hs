module Euler.Pipeline where

import Euler.Parser
import Data.ByteString (ByteString)


build :: ByteString -> IO String
build config = do
    case parseConfiguration config of
        Left err ->
            error $ "Invalid Configuration: " ++ err

        Right config' ->
            return $ show $ map name (components config')
