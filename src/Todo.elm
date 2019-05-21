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


emptyState: Model
emptyState = { entries = [ { description = "First task" }, { description = "2nd task" } ] }

init : Maybe Model -> ( Model, Cmd msg )
init _ =
    ( emptyState , Cmd.none )


type alias Entry =
    { description : String
    }
type alias Model =
    { entries : List Entry
    }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    (model, Cmd.none)


view : Model -> Html Msg
view model =
    div [ class "todomvc-wrapper" ] [
        section [ class "todoapp" ] [showEntries model]
    ]

showEntries: Model -> Html Msg
showEntries model =
    section [ class "main" ] [
        ul [ class "todo-list"] (List.map showEntry model.entries)
    ]

showEntry: Entry -> Html Msg
showEntry entry =
    li [] [
        div [class "view"] [
            label [] [ text entry.description ]
        ]
    ]
