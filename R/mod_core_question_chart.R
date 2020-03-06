#' core_question_chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_core_question_chart_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(outputId = ns("question_chart"))
  )
}
    
#' core_question_chart Server Function
#'
#' @noRd 
mod_core_question_chart_server <- function(input, output, session, question, attribute){
  ns <- session$ns
  
 output$question_chart <- renderPlot(
   question_facet_plot(data = shinycsps::all_defra_2019,
                       questions = unlist(strsplit(question(), split = " ")),
                       facet = attribute())
 )
 
}


question_facet_plot <- function(data, questions, facet, title = NULL, subtitle = NULL, caption = NULL){
  facet <- rlang::sym(facet) #why does this have to be sym?
  questions <- rlang::enquos(questions) # and this enquos? Both outputs from a selectInput
  
  plot_data <- data %>%
    dplyr::select(!!!questions, !!facet) %>% 
    tidyr::pivot_longer(                  # turn the data into 'long' format
      cols = -!!facet,                #    using all the columns
      names_to = "question",              #    assign names to variable 'question'
      values_to = "value"                 #    assign values to variable 'value' 
    ) %>%
    tidyr::drop_na(value, !!facet) %>%             # drops any missing responses
    dplyr::count(                                # count the combinations of:
      !!facet,
      question,                           #   question, and
      value,                              #   value, and
      name = "response_count") %>%        #   give the count a specific name
    dplyr::add_count(
      !!facet,
      question,                           # add an extra count by question
      wt = response_count,                #   summing the 'wt' variable
      name = "question_count") %>%        #   give it a specific name
    dplyr::mutate(
      pc = response_count/question_count, # calculate responses as % of question
      value = forcats::fct_rev(value),    # character strings are often better as
      question = forcats::fct_rev(        #   factors when plotting, but sometimes
        forcats::as_factor(question)      #   you need to reverse their 'order'
      )
    ) %>% dplyr::filter(question_count >=10)
  
  # return(plot_data)
  ggplot2::ggplot(plot_data, ggplot2::aes(x = question, y = pc)) +
    ggplot2::geom_col(ggplot2::aes(fill = value), width = 0.75, colour = "gray60", size = 0.2) +
    ggplot2::geom_text(
      ggplot2::aes(
        label = scales::percent(pc, accuracy = 1),
        colour = value),
      position = ggplot2::position_fill(vjust = 0.5),
      size = 3,
      show.legend = FALSE) +
    # geom_text adds text labels, we set the label aesthetic to the text
    # we've also mapped the colour aesthetic to vary the label text's colour
    # text positioning can be tricky, this is why the value factor was reversed
    # when we created plot_data2 ¯\_(ツ)_/¯
    ggplot2::scale_y_reverse() +
    # reverse the y-axis so that strongly agree will be on the left-hand side
    ggplot2::scale_fill_brewer(palette = "PiYG", direction = -1) +
    # the PiYG palette is the same as is used in the highlights reports
    # it is colourblind friendly, so recommended instead of basic red-green
    ggplot2::scale_colour_manual(
      values = c("Strongly agree" = "white",
                 "Agree" = "gray20",
                 "Neither agree nor disagree" = "gray20",
                 "Disagree" = "gray20",
                 "Strongly disagree" = "white")
    ) +
    # this provides the colours for the text labels, so that the labels for the
    # 'strongly' values have white text, and the others have grey text
    ggplot2::coord_flip() +
    # flip the axis
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      caption = caption) +
    ggplot2::theme_light() +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      # element_blank() removes an element from the plot
      panel.border = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      legend.position = "top",
      legend.title = ggplot2::element_blank(),
      legend.key.size = ggplot2::unit(1, "char"),
      legend.margin = ggplot2::margin(1,0,0,0, "char"),
      plot.title = ggplot2::element_text(face = "bold")) +
    ggplot2::facet_wrap(ggplot2::vars(!!facet), labeller = ggplot2::label_wrap_gen())
  
}


    
## To be copied in the UI
# mod_core_question_chart_ui("core_question_chart_ui_1")
    
## To be copied in the server
# callModule(mod_core_question_chart_server, "core_question_chart_ui_1")
 
