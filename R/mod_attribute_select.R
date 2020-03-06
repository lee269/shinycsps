#' attribute_select UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_attribute_select_ui <- function(id){
  ns <- NS(id)
  
  attributes <- shinycsps::attributes %>% 
    dplyr::select(text, question) %>% 
    tibble::deframe()
  
  tagList(
    selectInput(inputId = ns("attributes"), label = "select attribute", choices = attributes)
  )
}
    
#' attribute_select Server Function
#'
#' @noRd 
mod_attribute_select_server <- function(input, output, session){
  ns <- session$ns
  output$attribute <- renderText(input$attributes)
}
    
## To be copied in the UI
# mod_attribute_select_ui("attribute_select_ui_1")
    
## To be copied in the server
# callModule(mod_attribute_select_server, "attribute_select_ui_1")
 
