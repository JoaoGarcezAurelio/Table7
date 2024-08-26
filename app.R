source("data_cleaning.R")

thematic_shiny()

ui <- page_fluid(
  theme = bs_theme(preset = "minty"),
  headerPanel("Table 7 - The association between quality of delivery and outcomes as reported across studies (N = 10)"),
  reactableOutput("Table7"),
  textInput("footnote", "* indicates a negative association; ** indicates a significant interaction; *** ES calculated by research team when not reported in paper using ES calculator psychometrica.de",
            width = "100%"))

server <- function(input, output) {
  output$Table7 <- renderReactable({
    reactable(Table7,
              theme = default(centered = TRUE),
              filterable = TRUE,
              bordered = FALSE,
              striped = FALSE,
              highlight = TRUE,
              searchable = TRUE,
              defaultPageSize = 16,
              groupBy = "Outcome Domain",
              columns = list(
                Study_ID = colDef(
                  align = "center",
                  maxWidth = 130,
                  name = "Study ID",
                  cell = function(value, index) {
                    label4 <- DOITable7[index, "Study_ID"] # had to create a separate file for the DOIs for this table and just replaced label1 with label3 in case there was the risk of some overwriting. Same for DOI3 below
                    DOI4 <- DOITable7[index, "DOI"]
                    htmltools::div(
                      htmltools::p(
                        htmltools::tags$a(href = DOI4, target = "_blank", label4)
                      ),
                    )
                  }
                ),
                "First Author" = colDef(
                  align = "left",
                  maxWidth = 130
                ),
                Year = colDef(
                  align = "center",
                  maxWidth = 130
                ),
                Country = colDef(
                  header = with_tooltip("Country", 
                                        "Country where data was collected"),
                  maxWidth = 130
                ),
                CountryFlag = colDef(
                  name = "",
                  maxWidth = 70,
                  align = "center",
                  cell = embed_img("Country",
                                   height = "25",
                                   width = "40")
                ),
                "Outcome Domain" = colDef(
                  align = "center",
                  header = with_tooltip("Outcome Domain", 
                                        "Student outcome(s) assessed"),
                ),
                "Classification" = colDef(
                  header = with_tooltip("Classification", "Classification Quality"),
                  align = "center",
                  maxWidth = 120,
                  cell = pill_buttons(Table7,
                                      color_ref = "Classification_colours", 
                                      opacity = 0.7),
                ),
                "Classification_colours" = colDef(
                  show = FALSE),
                "Total Tests" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Total Tests", 
                    "Total of statistical tests performed"),
                  cell = data_bars(Table7,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Statistically Significant Tests" = colDef(
                  align = "center",
                  maxWidth = 190,
                  header = with_tooltip(
                    "Statistically Significant Tests", 
                    "Total of statistically significant tests"),
                  cell = data_bars(Table7,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Effect Size" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Effect Size", 
                    "Effect Sizes and their range, where applicable, for statistically significant effects")
                )
              )
    )
})

}

# Run the application 
shinyApp(ui = ui, server = server)
