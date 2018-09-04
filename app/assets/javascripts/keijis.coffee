# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# カレンダー表示用
ready = ->
    dateFormat = 'yy-mm-dd';
    $('.date-picker').datepicker(
        dateFormat: dateFormat,
        minDate: new Date(),
        maxDate: "+6m",
        firstDay: 1
    );
$(document).ready(ready)
$(document).on('turbolinks:load', ready)
