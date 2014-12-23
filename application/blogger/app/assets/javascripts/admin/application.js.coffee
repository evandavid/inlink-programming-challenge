# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'page:receive', ->
  tinymce.remove()
  
  return

$(document).ready ->
  tinyMCE.init
    mode: "textareas"
    theme: "modern"
    editor_selector: "tinymce"
    plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern uploadimage"
    ],
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | print preview media | forecolor backcolor emoticons | link uploadimage",

  return

$(document).on 'click', '#preview', ->
  title = $("#titlePost").val()
  content = tinyMCE.get('contentPost').getContent()

  if title isnt "" and content isnt ""
    $("#title_prev").val title
    $("#content_prev").val content
    $("#preview_form").submit()
  else
    alert "title and content cannot be blank"

  return false