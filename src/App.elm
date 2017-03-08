module App exposing (..)

import View exposing (..)
import Html exposing (..)
import Types exposing (..)
import State exposing (..)


main =
    Html.program
        { view = View.view
        , update = State.update
        , init = State.initialState
        , subscriptions = \_ -> Sub.none
        }
