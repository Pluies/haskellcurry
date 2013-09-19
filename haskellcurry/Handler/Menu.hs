module Handler.Menu where

import Import

entryForm :: Form CurryOrder
entryForm = renderDivs $ CurryOrder
    <$> areq   textField "Curry Type" Nothing
    <*> areq   textField "Hotness (Mild/Medium/Hot)" Nothing
    <*> areq   textField "Garlic Naan? (extra dollar)" Nothing
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
