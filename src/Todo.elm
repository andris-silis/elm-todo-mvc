module Todo exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Json.Decode as Json
-- import String


main : Program (Maybe Model) Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type Msg
    = Increment
    | Decrement


init : Maybe Model -> ( Model, Cmd msg )
init _ =
    ( 0, Cmd.none )


type alias Model =
    Int


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment -> (model + 1, Cmd.none)
        Decrement -> (model - 1, Cmd.none)


view : Model -> Html Msg
view model =
    div [] [
        button [onClick Increment] [ text "Increment" ]
        , div [] [text (String.fromInt model)]
        , button [onClick Decrement] [ text "Decrement" ]
    ]
