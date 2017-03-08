module State exposing (..)

import Types exposing (..)
import Process exposing (..)
import Time exposing (..)
import Task exposing (..)
import Dict exposing (..)
import Maybe exposing (andThen)
import Array exposing (..)


initialState =
    ( { position = { x = 0, y = 0 }
      , grid = Dict.empty
      , direction = North
      }
    , Task.perform (\_ -> Move) (Process.sleep (0.2 * Time.second))
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Move ->
            let
                ( squarecol, newGrid ) =
                    getColour model

                ( newD, newPos ) =
                    calcMove model.direction model.position squarecol
            in
                ( { model | grid = newGrid, position = newPos, direction = newD }, Task.perform (\_ -> Move) (Process.sleep (0.2 * Time.second)) )


getColour model =
    let
        a =
            (Dict.get ( model.position.x, model.position.y ) model.grid)
    in
        ( maybeToDefaultColour a
        , Dict.update
            ( model.position.x, model.position.y )
            (\b ->
                b
                    |> maybeToDefaultColour
                    |> swapColour
                    |> Just
            )
            model.grid
        )


maybeToDefaultColour colour =
    case colour of
        Just a ->
            a

        Nothing ->
            White


swapColour : Colour -> Colour
swapColour colour =
    case colour of
        White ->
            Black

        Black ->
            White


calcMove : Compass -> Position -> Colour -> ( Compass, Position )
calcMove compass pos col =
    case ( compass, col ) of
        ( North, Black ) ->
            ( West, { x = pos.x - 1, y = pos.y } )

        ( North, White ) ->
            ( East, { x = pos.x + 1, y = pos.y } )

        ( South, Black ) ->
            ( East, { x = pos.x + 1, y = pos.y } )

        ( South, White ) ->
            ( West, { x = pos.x - 1, y = pos.y } )

        ( East, Black ) ->
            ( North, { x = pos.x, y = pos.y + 1 } )

        ( East, White ) ->
            ( South, { x = pos.x, y = pos.y - 1 } )

        ( West, Black ) ->
            ( South, { x = pos.x, y = pos.y - 1 } )

        ( West, White ) ->
            ( North, { x = pos.x, y = pos.y + 1 } )
