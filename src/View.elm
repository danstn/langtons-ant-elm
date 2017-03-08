module View exposing (..)

import Types exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Dict exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


view : Model -> Html msg
view model =
    svg
        [ Svg.Attributes.width "100vw"
        , Svg.Attributes.height "100vh"
        , viewBox "-100 -100 200 200"
        ]
        [ gridView model.grid
        ]


gridView grid =
    g []
        (Dict.toList grid |> List.map (uncurry positionView))


positionView pos col =
    rect
        [ x <| toString <| Tuple.first pos * 10
        , y <| toString <| Tuple.second pos * 10
        , Svg.Attributes.width <| toString 10
        , Svg.Attributes.height <| toString 10
        , fill (toColourCode col)
        , stroke "black"
        ]
        []


toColourCode colour =
    case colour of
        Black ->
            "black"

        White ->
            "white"
