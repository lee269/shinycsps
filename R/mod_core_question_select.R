# Module UI
  
#' @title   mod_core_question_select_ui and mod_core_question_select_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_core_question_select
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_core_question_select_ui <- function(id){
  ns <- NS(id)
  
  
  questions <- shinycsps::core_questions %>% 
    tibble::deframe()
  
  tagList(
    selectInput(inputId = ns("core_questions"), label = "select question", choices = questions)
  )
}
    
# Module Server
    
#' @rdname mod_core_question_select
#' @export
#' @keywords internal
    
mod_core_question_select_server <- function(input, output, session){
  ns <- session$ns
  output$question <- renderText(input$core_questions)
}
    
## To be copied in the UI
# mod_core_question_select_ui("core_question_select_ui_1")
    
## To be copied in the server
# callModule(mod_core_question_select_server, "core_question_select_ui_1")
 
