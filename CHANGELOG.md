## version 0.0.1

## COMPONENTS

-------------------------------------------
1. ## VCProductElevatedButton

  * A customizable elevated button with various properties like text, child widget, button type, callback function on press, background color, size, etc.
  * Supports different button types such as standard, disabled, outlined, and outlined disabled.
  * Provides methods to build elevated and outlined buttons based on the specified type.

    Inputs:
    1. text: The text to display on the button (optional).
    2. child: A custom widget to use as the button's child (optional).
    3. type: The type of the button (standard, disabled, outlined, or outlined disabled).
    4. onPressed: Callback function when the button is pressed.
    5. backgroundColor: The background color of the button (optional).
    6. size: The size of the button (small, medium, large) (optional).
    7. fontSize: The font size of the button text.
    8. fixedSize: The fixed size of the button.
    9. borderColor: The border color of the button.
    10. typogaphyType: The typography type of the button.


-------------------------------------------
2. ## VCProductSelectableButtonList<T> 

  * A group of buttons that can be displayed horizontally or vertically.
  * Supports mutual exclusion (like a radio button group) or multiple selections.
  * Customizable with options like button layout, padding, text styles, colors, etc.
  * Utilizes a controller for managing the state and behavior of the button group.

    Inputs:
    1. buttons: The list of buttons to be displayed in the group.
    2. disabledButtons: The list of indexes of buttons that should be disabled initially.
    3. onSelected: Callback function invoked when a button is selected.
    4. onDisablePressed: Callback function invoked when a disabled button is pressed.
    5. isRadio: Flag indicating whether the group functions as a radio button group.
    6. enableDeselect: Flag indicating whether deselecting a radio button is enabled.
    7. maxSelected: The maximum number of buttons that can be selected (for non-radio groups).
    8. direction: The direction in which the buttons are laid out (horizontal or vertical).
    9. padding: Padding applied to each button within the group.
    10. selectedTextStyle: Text style applied to the selected buttons.
    11. unselectedTextStyle: Text style applied to the unselected buttons.
    12. selectedColor: Color applied to the background of selected buttons.
    13. unselectedColor: Color applied to the background of unselected buttons.
    14. borderRadius: The border radius of the buttons.
    15. buttonWidth: The width of each button.
    16. buttonHeight: The height of each button.
    17. textAlign: The horizontal alignment of the button group.
    18. alignment: The alignment of the button group within its parent widget.
    19. elevation: The elevation of the buttons.
    20. controller: The controller managing the state and behavior of the button group.


-------------------------------------------
3. ## VCCarousel<T>

  * A carousel/slider component with options for customization.
  * Supports various features like auto-play, infinite scrolling, aspect ratio, indicator options, etc.
  * Displays a set of items using the provided itemBuilder.
  * Includes an indicator at the bottom for navigation.

    Inputs:
    1. items: List of items to be displayed in the carousel.
    2. itemBuilder: A function that builds a widget for each item.
    3. onPageChange: Callback function invoked when the carousel page changes.
    4. disableGesture: Flag indicating whether gesture-based navigation is disabled.
    5. carouselController: Controller for managing the state and behavior of the carousel.
    6. indicatorEffect: The effect to be applied to the carousel indicator.
    7. indicatorMargin: Padding applied to the carousel indicator.
    8. height: The height of the carousel.
    9. aspectRatio: Aspect ratio of the carousel items.
    10. viewportFraction: The fraction of the viewport that each page should occupy.
    11. initialPage: The initial page to show when the carousel is created.
    12. enableInfiniteScroll: Flag indicating whether the carousel should loop infinitely.
    13. animateToClosest: Flag indicating whether the carousel should loop to the closest requested page.
    14. reverse: Flag indicating whether the order of items should be reversed.
    15. autoPlay: Flag indicating whether auto play is enabled.
    16. autoPlayInterval: Duration determining the frequency of slides during auto play.
    17. autoPlayAnimationDuration: The animation duration between two transitioning pages in auto playback.
    18. autoPlayCurve: The animation curve physics during auto play.
    19. enlargeCenterPage: Whether the current page should be larger than the side images.
    20. pageSnapping: Flag to enable/disable page snapping.
    21. pauseAutoPlayOnTouch: Pause auto play when the user interacts with the carousel.
    22. pauseAutoPlayOnManualNavigate: Pause auto play during manual navigation.
    23. pauseAutoPlayInFiniteScroll: Pause auto play when reaching the last item in finite scroll.
    24. enlargeStrategy: The strategy to enlarge the center page.
    25. enlargeFactor: The factor by which pages next to the center page will be scaled down.
    26. disableCenter: Flag to disable the Center widget for each slide.
    27. padEnds: Add padding to both ends of the list.


-------------------------------------------
4. ## VCProductCheckBox

  * A checkbox component with customizable options.
  * Displays a checkbox with an optional text label.
  * Supports customization of checkbox size, border radius, icon size, colors, etc.
  * Executes a callback function when the checkbox state changes.

    Inputs:
    1. text: Text to be displayed next to the checkbox.
    2. onChanged: Callback function when the checkbox state changes.
    3. disabled: Flag to determine if the checkbox is disabled.
    4. isChecked: Flag to determine if the checkbox is checked.
    5. borderRadius: Radius of the checkbox border.
    6. width: Width of the checkbox.
    7. height: Height of the checkbox.
    8. iconSize: Size of the check icon inside the checkbox.
    9. checkColor: Color of the check icon.
    10. textColor: Color of the text.
    11. icon: Widget to replace the default check icon.
    12. widget: Widget to replace the default text.
    13. iconMargin: Margin around the check icon.


-------------------------------------------
5. ## VCProductDatePicker

  * A date picker component with validation and customizable options.
  * Displays a text field with an associated calendar icon.
  * Allows users to pick a date within a specified range and with optional holiday restrictions.
  * Executes a callback function when a date is selected.
  * These components seem to be part of a larger Flutter project, providing reusable UI elements for building user interfaces. If you have specific questions about any of these components or need more detailed explanations, feel free to ask!
    
    Inputs:
    1. onDaySelected: The function called when a day is selected.
    2. controller: The TextEditingController of the date picker.
    3. initialDate: The initial date of the date picker.
    4. holidayList: The list of holidays (optional).
    5. hideHolidays: Boolean value to hide holidays (optional).
    6. minDate: The minimum date of the date picker.
    7. maxDate: The maximum date of the date picker.
    8. hideFutureDates: Boolean value to hide future dates.
    9. hidePreviousDates: Boolean value to hide previous dates.
    10. label: The label of the date picker.
    11. locale: The locale of the date picker.
    12. validator: The validator function of the date picker (optional).


-------------------------------------------
6. ## VCProductDropdown

  * A dropdown component for selecting items.
  * Displays a dropdown button with a label.
  * Supports item validation and customization.
  * Provides callbacks for item selection.
    
    Inputs:
    1. dropdownItems: List of items in the dropdown.
    2. label: Label text for the dropdown.
    3. initialValue: Initial value for the dropdown (optional).
    4. validator: Validator function for dropdown values (optional).
    5. isDisabled: Flag indicating whether the dropdown is disabled.
    6. isSearchBoxDisabled: Flag indicating whether the search box is disabled.
    7. onChanged: Callback function for item selection.
    8. selectedItemWidget: Widget builder for selected items.
    9. selectableItemWidget: Widget builder for selectable items.

-------------------------------------------
## VCListView

  * A paginated ListView with customizable options.
  * Supports infinite scrolling, normal pagination, or none.
  * Provides callbacks for new page loading.
  * Displays loading indicators and action buttons.

    Inputs:
    1. currentPageNumber: Initial page number.
    2. totalPageNumber: Total number of pages.
    3. containerHeight, containerWidth: Container dimensions.
    4. containerMargin, containerPadding: Container margins and padding.
    5. containerBoxDecoration: Container decoration.
    6. marginPaginatorTop, marginPaginatorBottom: Paginator margins.
    7. paginatorBackgroundColor, paginatorSelectedBackgroundColor: Paginator colors.
    8. paginatorTextColor, paginatorSelectedTextColor: Paginator text colors.
    9. paginatorBorder, paginatorSelectedBorder: Paginator borders.
    10. paginatorBorderRadius: Paginator border radius.
    11. spaceBetweenPaginators: Space between paginators.
    12. paginatorHeight: Paginator height.
    13. paginatorTextStyle, paginatorSelectedTextStyle: Paginator text styles.
    14. isShowButton: Flag to show an action button.
    15. marginButtonTop, marginButtonBottom: Action button margins.
    16. buttonHeight: Action button height.
    17. buttonText: Action button text.
    18. buttonBackgroundColor, buttonTextColor: Action button colors.
    19. buttonBorderRadius, buttonBorderSide: Action button border properties.
    20. buttonDisabledBackgrondColor, buttonDisabledTextColor: Disabled button colors.
    21. isButtonDisabled: Flag indicating whether the button is disabled.

-------------------------------------------
7. ## VCMap

  * A map component with customizable options.
  * Supports markers, initial camera position, and user location.
  * Provides callbacks for map events.

    Inputs:
    1. onMapCreated: Callback for map creation.
    2. onTapMap, onLongTapMap: Callbacks for map tapping.
    3. initialCameraPosition: Initial camera position.
    4. mapType: Map type (normal, satellite, etc.).
    5. markers: List of markers.
    6. myLocationButtonEnabled, myLocationEnabled: User location options.
    7. zoomControlsEnabled: Flag for enabling zoom controls.
    8. height, width: Container dimensions.
    9. padding: Container padding.
    10. borderRadius: Container border radius.

-------------------------------------------
8. ## VCCustomPaginator

   * A customizable paginator for indicating and navigating between pages.

        Inputs:
        1. currentPage, totalPage: Current and total page numbers.
        2. onNewPage: Callback for navigating to a new page.
        3. paginatorHeight: Paginator height.
        4. paginatorBackgroundColor, paginatorSelectedBackgroundColor: Paginator colors.
        5. paginatorTextColor, paginatorSelectedTextColor: Paginator text colors.
        6. paginatorBorder, paginatorSelectedBorder: Paginator borders.
        7. paginatorBorderRadius: Paginator border radius.
        8. spaceBetweenPaginators: Space between paginators.
        9. paginatorTextStyle, paginatorSelectedTextStyle: Paginator text styles.
   
--------------------------------------------
9. ## VCProductSwitch

   * VCProductSwitch is a customizable switch widget with various properties like initial state, disabled state, ON/OFF text,
   * custom widget, callback function on state change, and color customization options.
   * It supports dynamic width calculation based on the length of ON and OFF text when onOffDisable is set to false.

       Inputs:
       1. isSelected (bool): Determines the initial state of the switch.
       2. disabled (bool): Specifies whether the switch is interactable.
       3. text (String): Represents the text associated with the switch.
       4. onChanged (ValueChanged<bool>?): Callback function triggered when the switch state changes.
       5. onOffDisable (bool): Controls the display of ON and OFF state texts.
       6. onText (String): Specifies the text for the ON state.
       7. offText (String): Specifies the text for the OFF state.
       8. widget (Widget): Custom widget associated with the switch.
       9. textColor (Color): Text color associated with the switch.
       10. selectedColor (Color): Color used when the switch is in the selected (ON) state.
       11. backgroundColor (Color): Background color of the switch.
       12. circleColor (Color): Color of the circle inside the switch.


--------------------------------------------

10. # VCProductFilePicker

    * A customizable file picker for selecting files. 
    * It has two modes as named constructor: single file selection and multiple file selection.

      VCProductFilePicker.singleFilePicker
        Inputs:
        1. validator: validator function for file selection.
        2. allowedExtensions: allowed file extensions.
        3. onChanged: callback function for file selection, deletion.
        4. previewWidget: widget for previewing the selected file. It is optional. If it is not provided, default preview widget (just for image) will be used.
        5. title: title of the file picker.
        6. label: label of the file picker.
        7. isCheckBoxEnabled: flag for enabling checkbox for file selection.
        8. onCheckBoxTapped: callback function for checkbox selection.
        9. infoText: info text for the file picker.

      VCProductFilePicker.multipleFilePicker
      Inputs:
        1. validator: validator function for file selection.
        2. allowedExtensions: allowed file extensions.
        3. onFilesChanged: callback function for files selection, deletion.
        4. previewWidget: widget for previewing the selected file. It is optional. If it is not provided, default preview widget (just for image) will be used.
        5. title: title of the file picker.
        6. label: label of the file picker.
        7. isCheckBoxEnabled: flag for enabling checkbox for file selection.
        8. onFilesCheckBoxTapped: callback function for checkbox selection.
        9. infoText: info text for the file picker.


--------------------------------------------
11. # VCProductRadioButtonList

    * VCProductRadioButtonList is a widget that represents a list of radio buttons or checkboxes.
    * It allows users to select one or more options from the provided list.
    * Below is a summary of the widget's features and the input parameters:
    
    Inputs:
       1. values (List<T>): The list of values to display as radio buttons or checkboxes.
       2. selectedValueIndex (int?): The index of the initially selected value.
       3. controller (RadioButtonController?): Controller for managing the state of the radio buttons or checkboxes.
       4. onSelected (void Function(T button, int index, bool isSelected)?): Callback function called when a button is selected.
       5. onDisablePressed (Function(int)?): Callback function called when a disabled button is pressed.
       6. disabledValues (List<int>): List of indexes representing disabled buttons.
       7. isRadio (bool): Flag indicating whether the widget should behave as a radio button (single selection).
       8. enableDeselect (bool?): Flag indicating whether deselection is allowed for radio buttons.
       9. maxSelected (int?): Maximum number of selected values allowed (for checkboxes).
       10. padding (EdgeInsets): Padding around each button.
       11. textStyle (TextStyle?): Text style applied to the button's label.
       12. disabledTextStyle (TextStyle?): Text style applied to the button's label when disabled.
       13. unselectedBorderColor (Color?): Border color of the unselected checkbox.
       14. radioButtonOutlineSize (double?): Size of the outline around the radio button or checkbox.
       15. radioButtonInlineSize (double?): Size of the inner inline part of the radio button or checkbox.
       16. radioButtonOutlineWidth (double?): Width of the outline around the radio button or checkbox.
       17. selectedColor (Color?): Background color of the button when selected.


--------------------------------------------
12. # VCProductRadioButtonList

    * VCProductSelectableButtonList is a widget that represents a list of selectable buttons, allowing users to choose one or more options from the provided list. 
    * Below is a summary of the widget's features and the input parameters:
    
    Inputs:
    1. buttons (List<T>): The list of items to display as selectable buttons.
    2. disabledButtons (List<int>): List of indexes representing disabled buttons.
    3. selectedButtonIndex (int?): The index of the initially selected button.
    4. onSelected (void Function(T button, int index, bool isSelected)?): Callback function called when a button is selected.
    5. onDisablePressed (Function(int)?): Callback function called when a disabled button is pressed.
    6. isRadio (bool): Flag indicating whether the widget should behave as a radio button (single selection).
    7. enableDeselect (bool?): Flag indicating whether deselection is allowed for radio buttons.
    8. maxSelected (int?): Maximum number of selected buttons allowed (for checkboxes).
    9. direction (Axis): The direction in which the buttons are arranged (horizontal or vertical).
    10. padding (EdgeInsets): Padding around each button.
    11. selectedTextStyle (TextStyle?): Text style applied to the button's label when selected.
    12. unselectedTextStyle (TextStyle?): Text style applied to the button's label when unselected.
    13. selectedColor (Color?): Background color of the button when selected.
    14. unselectedColor (Color?): Background color of the button when unselected.
    15. borderRadius (double): The border radius of the button.
    16. buttonWidth (double?): The width of each button.
    17. buttonHeight (double?): The height of each button.
    18. textAlign (TextAlign): The horizontal alignment of the button text.
    19. alignment (AlignmentGeometry?): The alignment of the button within its parent widget.
    20. elevation (double?): The elevation of the button.
    21. controller (SelectableButtonController?): Controller for managing the state of the selectable buttons.
    22. isBorderVisible (bool): Flag indicating whether the button's border is visible.



--------------------------------------------
13. # VCProductSlider

* A customizable slider for selecting different values


       Inputs: 
       1. onChanged: The callback function for the user interaction of the slider.
       2. min: The minimum value of the slider.
       3. max: The maximum value of the slider.
       4. initialValue: The initial value of the slider. (optional)
       5. divisions: The number of discrete divisions.
       6. prefix: The prefix text of the slider. (optional)
       7. suffix: The suffix text of the slider. (optional)



        final Function(double) onChanged;

--------------------------------------------
14. # VCProductCaptcha

* A customizable captcha for selecting different values


      Inputs: 
      1. label: The label text displayed above the input field. (Default: "Captcha")
      2. helperText: Helper text that appears below the input field to provide additional guidance.
      3. errorText: Error text displayed below the input field when validation fails.
      4. hintText: Hint text displayed inside the input field when it's empty.
      5. maxLength: Maximum allowed length for the input value.
      6. hint: A brief hint that is displayed inside the input field when it's empty.
      7. style: The style of the text within the input field.
      8. controller: The controller for this text field, which can be used to control and observe the input text.
      9. validator: A function that validates the input value and returns an error message if invalid.
      10. refresh: A callback that is called when the captcha needs to be refreshed.
      11. onChanged: A callback that is called when the input value changes.

