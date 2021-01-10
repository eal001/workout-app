# Workout App; By Elliot Lee

## Project Goals
I want a workout app that can fully track my exercises whatever they may be and however my progression and lifts are set up. In the future i would 
like the functionality to not just include weightlifting exercises but also other ones as well, possible timer and rest periods in the future.

## Current Functionality
the app can log multiple routines, each of which contain cycles(weeklike structures that contain daily exercise plans). Each set of exercise plans 
contain multiple exercises and within those exercises sets that we want to set as complete or incomplete. We can create and fully customize these 
aspects, and we can use them once made (setting weight/reps/names). 
can keep track of the maximum reps/weight and volume sets done for each exercise
can display the volume per date per exercise in graphs 
can change color and weight units
Currently bug fixing with numerous issues, testing with personal use

## Known Bugs

>each routine is set up for linear progresstion, (should also have a manual mode)
>max label does not update after a text change until the set is marked/RE-marked as complete
>rest day , set rep/set weight, count with unreasonably large numbers do not work
>showing spaces when entering names, 
>disable keyboard on tap of different areas (nav bar) (tableview)
>constraints for smaller iphones
>shift up the tableview when writing to it (for sets)
>switch progression graph for weight or volume
>Accessory exercises automatically increase weight by 5 lbs and reset reps to 12 each time, no matter change
>sets do not update when editing numbers, they must be set and reset
>doesnt round on max reps information alert box (?)
>doesnt start on the max rep label for calisthenic exercises


## Planned Functionality

>add a screen to see how your strength in each percentile ranks whith others (probably by pinging a server)
>manual mode of progression for each routine
>make the input text fields a bit bigger and the cells
 
