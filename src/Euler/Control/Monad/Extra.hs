module Euler.Control.Monad.Extra where

import Data.List


concatMapM :: (Monad m) => (a -> m [b]) -> [a] -> m [b]
concatMapM f xs = fmap concat (mapM f xs)


uniqConcatMapM :: (Eq a, Monad m) => (a -> m [a]) -> [a] -> m [a]
uniqConcatMapM f xs = fmap nub (concatMapM f xs)
