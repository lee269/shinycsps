# Module UI
  
#' @title   mod_test_text_ui and mod_test_text_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_test_text
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_test_text_ui <- function(id){
  ns <- NS(id)
  tagList(
      tableOutput(outputId = ns("text"))
  )
}
    
# Module Server
    
#' @rdname mod_test_text
#' @export
#' @keywords internal
    
mod_test_text_server <- function(input, output, session, question){
  ns <- session$ns
  
  selected <- reactive({
    dt <- shinycsps::core_questions %>% 
            dplyr::filter(.data$question == question())
    return(dt)
  })
  
  output$text <- renderTable(selected())
}
    
## To be copied in the UI
# mod_test_text_ui("test_text_ui_1")
    
## To be copied in the server
# callModule(mod_test_text_server, "test_text_ui_1")
 
