local Translations = {
    error = {
        canceled = "Canceled!",
        failed_add_boxes = 'Failed to add recyclable boxes.',
        player_not_found = 'Error: Player object not found.',
        no_boxes = "You don't have any recyclable boxes to trade.",
    },
    success = {
        found_boxes = 'You found %{amount} recyclable boxes.',
        traded_boxes = "You've traded %{amount} boxes and received materials!",
        on_duty = "You're now on duty.",
        off_duty = "You're now off duty.",
    },
    info = {
        enter_warehouse = "[~g~E~s~] Enter Warehouse",
        exit_warehouse = "[~g~E~s~] Exit Warehouse",
        trade_boxes = "[~g~E~s~] Trade Recyclable Boxes",
        search = "[~g~E~s~] Search",
        on_duty_to_trade = "You must be on duty to trade.",
        searched_already = "~r~You have already searched here!",
        toggle_duty = "[~g~E~s~] Toggle Duty",
        what_are_you_doing = "What are you doing? GET ON DUTY!!!",
    },

}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

return Translations

