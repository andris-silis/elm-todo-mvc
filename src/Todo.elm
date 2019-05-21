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
    = Add
    | UpdateCurrentInputValue String


emptyState: Model
emptyState = { currentInputValue = "", entries = [ { description = "First task" }, { description = "2nd task" } ] }

init : Maybe Model -> ( Model, Cmd msg )
init _ =
    ( emptyState , Cmd.none )


type alias Entry =
    { description : String
    }
type alias Model =
    { entries : List Entry
    , currentInputValue : String
    }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Add ->
            let
                newEntry = { description = "New entry" }
                newEntries = List.append model.entries [ newEntry ]
            in

            ( { model | entries = newEntries }, Cmd.none)
        UpdateCurrentInputValue newInputValue ->
            ( { model | currentInputValue = newInputValue }, Cmd.none)


view : Model -> Html Msg
view model =
    div [ class "todomvc-wrapper" ] [
        button  [ onClick Add ] [ text "Add new entry" ]
        , section [ class "todoapp" ] [ showHeader model, showEntries model]
    ]

showHeader: Model -> Html Msg
showHeader model =
    header [ class "header" ] [
        h1 [] [ text "todos" ]
        , input [
            class "new-todo"
            , placeholder "What needs to be done"
            , value model.currentInputValue
            , onInput UpdateCurrentInputValue
        ] []
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
