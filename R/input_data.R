#' Launch a data-entry Shiny app
#'
#' Opens an interactive Shiny app with fields for Date, Trip, Captain,
#' and Measurement. Submitted rows are displayed in a table.
#'
#' @return Invisibly returns `NULL` after the app exits.
#' @export
input_data <- function() {
  ui <- shiny::fluidPage(
    shiny::titlePanel("Input Data"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::dateInput("date", "Date"),
        shiny::textInput("trip", "Trip"),
        shiny::textInput("captain", "Captain"),
        shiny::numericInput("measurement", "Measurement", value = NA_real_),
        shiny::actionButton("add", "Add entry")
      ),
      shiny::mainPanel(
        shiny::tableOutput("entries")
      )
    )
  )

  server <- function(input, output, session) {
    entries <- shiny::reactiveVal(
      data.frame(
        Date = as.Date(character()),
        Trip = character(),
        Captain = character(),
        Measurement = numeric(),
        stringsAsFactors = FALSE
      )
    )

    shiny::observeEvent(input$add, {
      req(input$date, input$trip, input$captain, !is.na(input$measurement))

      new_row <- data.frame(
        Date = as.Date(input$date),
        Trip = input$trip,
        Captain = input$captain,
        Measurement = input$measurement,
        stringsAsFactors = FALSE
      )

      entries(rbind(entries(), new_row))
    })

    output$entries <- shiny::renderTable({
      entries()
    })
  }

  shiny::runApp(shiny::shinyApp(ui = ui, server = server))
  invisible(NULL)
}
