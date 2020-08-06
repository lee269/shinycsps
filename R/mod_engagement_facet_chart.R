#' engagement_facet_chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_engagement_facet_chart_ui <- function(id){
  ns <- NS(id)
  tagList(
          plotOutput(outputId = ns("engagement_chart"))
  )
}
    
#' engagement_facet_chart Server Function
#'
#' @noRd 
mod_engagement_facet_chart_server <- function(input, output, session, oucode, eng1, eng2){
  ns <- session$ns
  
  oudata <- reactive({ 
    ou_data(data = shinycsps::all_defra_2019,
            hierarchy = shinycsps::all_defra_2019_hierarchy, 
            hierarchy_meta = shinycsps::all_defra_2019_hierarchy_metadata,
            oucode = oucode())
  })
  
  output$engagement_chart <- renderPlot(
    engagement_facet_plot(data = oudata(),
                          var1 = eng1(),
                          var2 = eng2()
                          )
  )
  
}
    


engagement_facet_plot <- function(data, var1, var2){
  var1 <- rlang::sym(var1)
  var2 <- rlang::sym(var2)
  
  plot_data <- data %>% 
    dplyr::select(!!var1, !!var2, ees) %>% 
    dplyr::group_by(!!var1, !!var2) %>% 
    dplyr::summarise(
      total_count = n(),
      ees_mean = round(mean(as.numeric(ees), na.rm = TRUE), 2)
    ) %>% 
    dplyr::ungroup() %>% 
    dplyr::filter(!is.na(!!var2)) %>% 
    dplyr::mutate(
      ees_mean_supp = ifelse(
        test = total_count < 10, yes = NA, no = ees_mean
      )
    )
  
  ggplot2::ggplot(plot_data, ggplot2::aes(x = !!var2, y = ees_mean_supp, fill = !!var2)) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::facet_wrap(ggplot2::vars(!!var1)) +
    ggplot2::theme_minimal()
  
  
}

## To be copied in the UI
# mod_engagement_facet_chart_ui("engagement_facet_chart_ui_1")
    
## To be copied in the server
# callModule(mod_engagement_facet_chart_server, "engagement_facet_chart_ui_1")
 
