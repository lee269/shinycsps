#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  df <- shinycsps::core_questions
  
  # question <- callModule(mod_question_select_server, "question_select_ui_1", df)
  core_question <- callModule(mod_core_question_select_server, "core_question_select_ui_1")
  att <- callModule(mod_attribute_select_server, "attribute_select_ui_1")
  ou <- callModule(mod_ou_select_server, "ou_select_ui_1")
  
  eng1 <-   attribute <- callModule(mod_attribute_select_server, "attribute_select_ui_eng_1")
  eng2 <-   attribute <- callModule(mod_attribute_select_server, "attribute_select_ui_eng_2")
  
  callModule(mod_core_question_chart_server, "core_question_chart_ui_1", oucode = ou, question = core_question, attribute = att)
  callModule(mod_engagement_facet_chart_server, "engagement_facet_chart_ui_1", oucode = ou, eng1 = eng1, eng2 = eng2)
  # callModule(mod_test_text_server, "test_text_ui_1", question = "B10")
}
