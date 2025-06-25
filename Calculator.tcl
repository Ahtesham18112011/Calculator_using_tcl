#!/usr/bin/env wish

# Variable to store the cumulative number string
set numberString ""

# Create the display and converter label
frame .converter

button .converter.back -text "← Back" -command {
    pack forget .converter
    pack .buttons
}
label .converter.label -text "Unit Converter" -font "Helvetica 18 bold" -anchor center
grid .converter.label -row 0 -column 0 -columnspan 2 -pady 5

entry .converter.input -width 10
entry .converter.output -width 10

label .display -textvariable numberString -font "Helvetica 36 bold" -width 10 -anchor center
pack .display -padx 10 -pady 10 -ipady 10

# Update procedure to append clicked digit
proc numberClicked {num} {
    global numberString
    append numberString $num
}
# Procedure to delete the last digit
proc deleteLastDigit {} {
    global numberString
    set numberString [string range $numberString 0 end-1]
}
# Procedure to evaluate the expression
proc evaluate {} {
    global numberString 
    catch {
        set numberString [expr $numberString]
    } err
}
# Procedure to calculate the square root
proc sqrt {} {
    global numberString
    set number [string index $numberString end]
    catch {
        set numberString [expr sqrt($number)]
    } err
}

# Global memory variable
set memValue 0

# Function to recall the memory value
proc memRecall {} {
    global memValue
    return $memValue
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
grid .buttons.clear -row 4 -column 0

# Add the decimal point button
button .buttons.decimal -text "." -width 4 -height 2 -command "numberClicked \".\""
grid .buttons.decimal -row 3 -column 2

# Add the add, subtract, multiply, and divide buttons
# These buttons will call the numberClicked procedure with the respective operator
button .buttons.add -text "+" -width 4 -height 2 -command "numberClicked \"+\" "
grid .buttons.add -row 0 -column 3

button .buttons.subtract -text "-" -width 4 -height 2 -command "numberClicked \"-\""
grid .buttons.subtract -row 1 -column 3

button .buttons.multiply -text "×" -width 4 -height 2 -command "numberClicked \"*\""
grid .buttons.multiply -row 2 -column 3

button .buttons.divide -text "÷" -width 4 -height 2 -command "numberClicked \"/\""
grid .buttons.divide -row 3 -column 3

button .buttons.equal -text "=" -width 4 -height 2 -command "evaluate"
grid .buttons.equal -row 4 -column 3
                                                                             
button .buttons.exp -text "EXP" -width 4 -height 2 -command "numberClicked \"**\""
grid .buttons.exp -row 4 -column 2

button .buttons.sqrt -text "√" -width 4 -height 2 -command {sqrt
                                                            numberClicked √ }
grid .buttons.sqrt -row 4 -column 1


# Add the 0 button
button .buttons.b0 -text 0 -width 4 -height 2 -command "numberClicked 0"
grid .buttons.b0 -row 3 -column 1

# Add the memory buttons
button .buttons.mr -text "MR" -width 4 -height 2 -command {
    global numberString
    set numberString [memRecall]
}
grid .buttons.mr -row 5 -column 0

button .buttons.ma -text "M+" -width 4 -height 2 -command {
    global memValue numberString
    catch {
        set memValue [expr $numberString]
    }
}
grid .buttons.ma -row 5 -column 1

button .buttons.ms -text "M-" -width 4 -height 2 -command {
    global memValue numberString
    catch {
        set memValue [expr {$memValue - $numberString}]
    }
}
grid .buttons.ms -row 5 -column 2

button .buttons.mc -text "MC" -width 4 -height 2 -command {
    global memValue
    set memValue 0
}
grid .buttons.mc -row 5 -column 3

# Add the converter buttons
button .converter.cmToIn -text "cm → inch" -command {
    set val [.converter.input get]
    catch {
        .converter.output delete 0 end
        .converter.output insert 0 [expr {$val / 2.54}]
    }
}


button .converter.inToCm -text "inch → cm" -command {
    set val [.converter.input get]
    catch {
        .converter.output delete 0 end
        .converter.output insert 0 [expr {$val * 2.54}]
    }
}

button .converter.ctoF -text "C → F" -command {
    set val [.converter.input get]
    catch {
        .converter.output delete 0 end
        .converter.output insert 0 [expr {($val * 9/5) + 32}]
    }
}
button .converter.ftoC -text "F → C" -command {
    set val [.converter.input get]
    catch {
        .converter.output delete 0 end
        .converter.output insert 0 [expr {($val - 32) * 5/9}]
    }
}



grid .converter.input -row 1 -column 1 -columnspan 2 -pady 5
grid .converter.output -row 2 -column 1 -columnspan 2 -pady 5

grid .converter.cmToIn -row 3 -column 1 -padx 5 -pady 5
grid .converter.inToCm -row 3 -column 0 -padx 5 -pady 5 
grid .converter.ctoF -row 4 -column 1 -padx 5 -pady 5
grid .converter.ftoC -row 4 -column 0 -padx 5 -pady 5
grid .converter.back -row 5 -column 0 -padx 5 -pady 10

pack .converter -side top -fill both -expand true
pack forget .converter  ;

button .buttons.switch -text " Converter" -width 10 -command {
    pack forget .buttons
    pack .converter
}
grid .buttons.switch -row 6 -column 0 -columnspan 4 -pady 10




button .buttons.clearAll -text "Clear " -width 10 -command {
catch {
        .converter.output delete 0 end
        .converter.output insert 0 [expr {0}]
    }
}

label .buttons.label -text "Calculator" -font "Helvetica 18 bold" -anchor center
label .converter.typeh -text "→"
grid .converter.typeh -row 1 -column 0 -columnspan 2 -pady 5
