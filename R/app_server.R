#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  df <- shinycsps::core_questions
  z <- data.frame(x = 1:10, y = LETTERS[1:10])
  
  # question <- callModule(mod_question_select_server, "question_select_ui_1", df)
  core_question <- callModule(mod_core_question_select_server, "core_question_select_ui_1")

  # callModule(mod_test_text_server, "test_text_ui_1", question = "B10")
}
