port module Todo exposing (Entry, Model, Msg(..), emptyModel, init, main, onEnter, setStorage, showEntries, showEntry, showFooter, showHeader, update, updateWithStorage, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Json.Decode as Json
import String


main : Program (Maybe Model) Model Msg
main =
    Browser.document
        { init = init
        , view = \model -> { title = "Elm Todo MVC - Workshop", body = [ view model ] }
        , update = updateWithStorage
        , subscriptions = \_ -> Sub.none
        }


emptyModel =
    { entries = []
    , currentUid = 0
    , currentInput = ""
    , filter = "All"
    }


init : Maybe Model -> ( Model, Cmd msg )
init newModel =
    ( Maybe.withDefault emptyModel newModel, Cmd.none )


port setStorage : Model -> Cmd msg


type alias Model =
    { entries : List Entry
    , currentUid : Int
    , currentInput : String
    , filter : String
    }


type alias Entry =
    { uid : Int
    , description : String
    , isCompleted : Bool
    }


type Filter
    = Completed
    | All
    | Active


type Msg
    = Add
    | ChangeInput String
    | Check Int
    | Delete Int
    | CheckAll
    | ChangeFilter String
    | ClearCompleted


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, cmds ) =
            update msg model
    in
    ( newModel
    , Cmd.batch [ setStorage newModel, cmds ]
    )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Add ->
            let
                newEntriesList =
                    List.append model.entries [ Entry model.currentUid model.currentInput False ]
            in
            ( { model | entries = newEntriesList, currentInput = "", currentUid = model.currentUid + 1 }, Cmd.none )

        ChangeInput newInput ->
            ( { model | currentInput = newInput }, Cmd.none )

        Check uid ->
            let
                checkEntry entry =
                    if entry.uid == uid then
                        { entry | isCompleted = not entry.isCompleted }

                    else
                        entry
            in
            ( { model | entries = List.map checkEntry model.entries }, Cmd.none )

        CheckAll ->
            let
                allCompleted =
                    List.all .isCompleted model.entries

                updateEntry e =
                    { e | isCompleted = not allCompleted }
            in
            ( { model | entries = List.map updateEntry model.entries }, Cmd.none )

        Delete uid ->
            ( { model | entries = List.filter (\e -> not (e.uid == uid)) model.entries }, Cmd.none )

        ChangeFilter filter ->
            ( { model | filter = filter }, Cmd.none )

        ClearCompleted ->
            ( { model | entries = List.filter (\e -> not e.isCompleted) model.entries }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "todomvc-wrapper" ]
        [ section [ class "todoapp" ]
            [ showHeader model
            , showEntries model
            , showFooter model
            ]
        ]


showHeader : Model -> Html Msg
showHeader model =
    header [ class "header" ]
        [ h1 [] [ text "todos" ]
        , input [ class "new-todo", value model.currentInput, placeholder "What needs to be done?", onEnter Add, onInput ChangeInput ] []
        ]


showEntries : Model -> Html Msg
showEntries model =
    let
        entries =
            case model.filter of
                "Completed" ->
                    List.filter (\e -> e.isCompleted) model.entries

                "Active" ->
                    List.filter (\e -> not e.isCompleted) model.entries

                _ ->
                    model.entries
    in
    section [ class "main" ]
        [ input [ class "toggle-all", type_ "checkbox", onClick CheckAll ] []
        , ul [ class "todo-list" ] (List.map showEntry entries)
        ]


showEntry : Entry -> Html Msg
showEntry entry =
    li [ classList [ ( "completed", entry.isCompleted ) ] ]
        [ div [ class "view" ]
            [ input [ class "toggle", type_ "checkbox", onClick (Check entry.uid), checked entry.isCompleted ] []
            , label [] [ text entry.description ]
            , button [ class "destroy", onClick (Delete entry.uid) ] []
            ]
        ]


showFooter model =
    let
        itemsLeftInTodo =
            List.filter (\e -> not e.isCompleted) model.entries |> List.length

        itemsDone =
            List.filter (\e -> e.isCompleted) model.entries |> List.length
    in
    footer [ class "footer" ]
        [ span [ class "todo-count" ]
            [ text (String.fromInt itemsLeftInTodo)
            , text " items left"
            ]
        , ul [ class "filters" ]
            [ li []
                [ a [ classList [ ( "selected", model.filter == "All" ) ], onClick (ChangeFilter "All") ] [ text "All" ]
                ]
            , li []
                [ a [ classList [ ( "selected", model.filter == "Active" ) ], onClick (ChangeFilter "Active") ] [ text "Active" ]
                ]
            , li []
                [ a [ classList [ ( "selected", model.filter == "Completed" ) ], onClick (ChangeFilter "Completed") ] [ text "Completed" ]
                ]
            ]
        , button [ class "clear-completed", onClick ClearCompleted ]
            [ text ("Clear Completed (" ++ String.fromInt itemsDone ++ ")")
            ]
        ]


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter key =
            if key == 13 then
                Json.succeed msg

            else
                Json.fail "Not Enter"
    in
    on "keydown" (Json.andThen isEnter keyCode)
