#' ou_select UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_ou_select_ui <- function(id){
  ns <- NS(id)
  
  ous <- shinycsps::all_defra_2019_hierarchy_metadata %>% 
          dplyr::mutate(label = paste0("(", OUcode, ") ", label)) %>% 
          dplyr::select(label, OUcode) %>% 
          tibble::deframe()
  
  tagList(
    selectInput(inputId = ns("ous"), label = "Select OU", choices = ous)
    )
}
    
#' ou_select Server Function
#'
#' @noRd 
mod_ou_select_server <- function(input, output, session){
  ns <- session$ns
 output$ou <- renderText(input$ous)
}
    
## To be copied in the UI
# mod_ou_select_ui("ou_select_ui_1")
    
## To be copied in the server
# callModule(mod_ou_select_server, "ou_select_ui_1")
 
