# Module UI
  
#' @title   mod_question_select_ui and mod_question_select_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_question_select
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_question_select_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    uiOutput(outputId = ns("control"))
  )
}
    
# Module Server
    
#' @rdname mod_question_select
#' @export
#' @keywords internal
    
mod_question_select_server <- function(input, output, session, df){
  
  output$control <- renderUI({
  ns <- session$ns
  
  questions <- df %>% 
    tibble::deframe()
  
    selectInput(inputId = ns("control"), label = "select question", choices = questions)
    })
  
}
    
## To be copied in the UI
# mod_question_select_ui("question_select_ui_1")
    
## To be copied in the server
# callModule(mod_question_select_server, "question_select_ui_1")
 
