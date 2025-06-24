#!/usr/bin/env wish

# Variable to store the cumulative number string
set numberString ""

# Create the display label
label .display -textvariable numberString -font "Helvetica 36 bold" -width 10 -anchor center
pack .display -padx 10 -pady 10 -ipady 10

# Update procedure to append clicked digit
proc numberClicked {num} {
    global numberString
    append numberString $num
}

proc deleteLastDigit {} {
    global numberString
    set numberString [string range $numberString 0 end-1]
}

proc evaluate {} {
    global numberString
    catch {
        set numberString [expr $numberString]
    } err
}

# Create the button frame
frame .buttons
pack .buttons

# Create buttons 1–9
foreach i {1 2 3 4 5 6 7 8 9} {
    set row [expr {($i - 1) / 3}]
    set col [expr {($i - 1) % 3}]
    button .buttons.b$i -text $i -width 4 -height 2 -command "numberClicked $i"
    grid .buttons.b$i -row $row -column $col
}

# Add the delete button
button .buttons.delete -text "Del" -width 4 -height 2 -command "deleteLastDigit"
grid .buttons.delete -row 3 -column 0

# Add the clear button
button .buttons.clear -text "C" -width 4 -height 2 -command "set numberString \"\""
grid .buttons.clear -row 3 -column 2

# Add the decimal point button
button .buttons.decimal -text "." -width 4 -height 2 -command "numberClicked \".\""
grid .buttons.decimal -row 4 -column 1

# Add the add, subtract, multiply, and divide buttons
# These buttons will call the numberClicked procedure with the respective operator
button .buttons.add -text "+" -width 4 -height 2 -command "numberClicked \"+\" "
grid .buttons.add -row 0 -column 3

button .buttons.subtract -text "-" -width 4 -height 2 -command "numberClicked \"-\""
grid .buttons.subtract -row 1 -column 3

button .buttons.multiply -text "*" -width 4 -height 2 -command "numberClicked \"*\""
grid .buttons.multiply -row 2 -column 3

button .buttons.divide -text "/" -width 4 -height 2 -command "numberClicked \"/\""
grid .buttons.divide -row 3 -column 3

button .buttons.equal -text "=" -width 4 -height 2 -command "evaluate"
grid .buttons.equal -row 3 -column 3
                                                                             
grid .buttons.add -row 0 -column 3


# Add the 0 button at the bottom center
button .buttons.b0 -text 0 -width 4 -height 2 -command "numberClicked 0"
grid .buttons.b0 -row 3 -column 1
