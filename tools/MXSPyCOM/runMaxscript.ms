data_str = "9 , mcAction.object_move_to_center(),Move To Center"
data_str = mcString.replaceInString data_str ", " ","
data_arr = filterString data_str ","
action = data_arr[2]
format "data:% action:%\n" data_arr action

execute action