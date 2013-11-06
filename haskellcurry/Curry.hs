{-# LANGUAGE TemplateHaskell #-}
module Curry where

import Database.Persist.TH
import Prelude

data Hotness = Mild | Medium | Hot
    deriving (Show, Read, Eq)
derivePersistField "Hotness"
