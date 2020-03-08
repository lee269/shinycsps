#' @import shiny
app_ui <- function() {
  

# UI elements -------------------------------------------------------------

  control_section <- column(width = 3,
                            mod_ou_select_ui("ou_select_ui_1"),
                            mod_attribute_select_ui("attribute_select_ui_1"),
                            mod_core_question_select_ui("core_question_select_ui_1")                    
                            )
  
  main_section <- column(width = 9,
                         mod_core_question_chart_ui("core_question_chart_ui_1")
                         )
  

# Main dashboard ----------------------------------------------------------

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      titlePanel("shinycsps"),
      control_section,
      main_section
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'shinycsps')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
