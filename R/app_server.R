#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  df <- shinycsps::core_questions
  
  # question <- callModule(mod_question_select_server, "question_select_ui_1", df)
  core_question <- callModule(mod_core_question_select_server, "core_question_select_ui_1")
  attribute <- callModule(mod_attribute_select_server, "attribute_select_ui_1")
  
  callModule(mod_core_question_chart_server, "core_question_chart_ui_1", question = core_question, attribute = attribute)

  # callModule(mod_test_text_server, "test_text_ui_1", question = "B10")
}
