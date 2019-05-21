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
    | Check Int


emptyState: Model
emptyState = { currentUid = 0, currentInputValue = "", entries = [ ] }

init : Maybe Model -> ( Model, Cmd msg )
init _ =
    ( emptyState , Cmd.none )


type alias Entry =
    { uid : Int
    , description : String
    , isCompleted : Bool
    }
type alias Model =
    { entries : List Entry
    , currentInputValue : String
    , currentUid : Int
    }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Add ->
            let
                newEntry = { uid = model.currentUid + 1, description = model.currentInputValue, isCompleted = False }
                newEntries = List.append model.entries [ newEntry ]
            in

            ( { model | entries = newEntries, currentInputValue = "", currentUid = model.currentUid + 1 }, Cmd.none)

        UpdateCurrentInputValue newInputValue ->
            ( { model | currentInputValue = newInputValue }, Cmd.none)

        Check uid ->
            let
                checkEntry : Entry -> Entry
                checkEntry entry =
                    if entry.uid == uid then
                        { entry | isCompleted = not entry.isCompleted }
                    else
                        entry

                newEntries = List.map checkEntry model.entries
            in
            ( { model | entries = newEntries }, Cmd.none)


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
            , onEnter Add
        ] []
    ]

showEntries: Model -> Html Msg
showEntries model =
    section [ class "main" ] [
        ul [ class "todo-list"] (List.map showEntry model.entries)
    ]

showEntry: Entry -> Html Msg
showEntry entry =
    li [ classList [ ( "completed", entry.isCompleted ) ] ] [
        div [class "view"] [
            input [
                class "toggle"
                , type_ "checkbox"
                , checked entry.isCompleted
                , onClick (Check entry.uid)
            ] []
            , label [] [ text entry.description ]
        ]
    ]

onEnter: Msg -> Attribute Msg
onEnter msg =
    let
        isEnter key =
            if key == 13 then
                Json.succeed msg
            else
                Json.fail "Not Enter"
    in
    on "keydown" (Json.andThen isEnter keyCode)
