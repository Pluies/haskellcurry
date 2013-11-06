module Handler.Menu where

import Import
import Curry

hotnesses :: [(Text, Curry.Hotness)]
hotnesses = [("Hot", Hot),
             ("Medium", Medium),
             ("Mild", Mild)]

curries :: [(Text, Text)]
curries = zip c c
     where c = ["Butter Chicken",
                "Chicken Korma",
                "Chicken Vindaloo",
                "Chicken Lavabdar",
                "Chicken Madras",
                "Chicken Masala",
                "Chicken Jalfrezi",
                "Rogan Josh",
                "Lamb Korma",
                "Lamb Vindaloo",
                "Lamb Madras",
                "Lamb Lavabdar",
                "Lamb Jalfrezi ",
                "Beef Curry",
                "Beef Korma",
                "Beef Madras",
                "Beef Lavabdar",
                "Beef Jalfrezi ",
                "Dal Makhani",
                "Vegetable Korma",
                "Vegetable Makhani",
                "Vegetable Curry",
                "Vegetable Lavabdar",
                "Aloo Matter",
                "Aloo Lavabdar"]

garlic :: [(Text, Bool)]
garlic = [("Yes please", True), ("No thanks", False)]

entryForm :: Form CurryOrder
entryForm = renderDivs $ CurryOrder
    <$> areq   (selectFieldList curries) "Select Your Curry" Nothing
    <*> areq   (selectFieldList hotnesses) "Hotness" Nothing
    <*> areq   (radioFieldList  garlic) "Garlic Naan instead of Plain Naan?" Nothing
    <*> areq   textField "Name" Nothing

getMenuR :: Handler Html
getMenuR = do
    (curryOrderWidget, enctype) <- generateFormPost entryForm
    defaultLayout $(widgetFile "menu")

postMenuR :: Handler Html
postMenuR = do
    ((res,curryOrderWidget),enctype) <- runFormPost entryForm
    case res of
         FormSuccess order -> do
            orderId <- runDB $ insert order
            setMessage $ toHtml $ (curryOrderUnderling order) <> " Ordered!"
            redirect $ MenuR
         _ -> defaultLayout $ do
                setMessage "Please fill ALL OF THE FIELDS."
                redirect $ MenuR
