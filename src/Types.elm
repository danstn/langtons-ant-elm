module Types exposing (..)

import Array exposing (Array)
import Dict exposing (..)


type alias Model =
    { position : Position
    , grid : Grid
    , direction : Compass
    }


type Compass
    = North
    | South
    | East
    | West


type alias Grid =
    Dict ( Int, Int ) Colour


type alias Position =
    { x : Int
    , y : Int
    }


type Msg
    = Move


type Direction
    = Left
    | Right


type Colour
    = Black
    | White
