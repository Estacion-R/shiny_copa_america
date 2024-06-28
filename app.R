library(shiny)
library(bslib)
library(brackets)
library(r2social)
library(shiny.telemetry)

# Data
source("global.R")

# Tracking 
telemetry <- Telemetry$new() # 1. Initialize telemetry with default options

# App
ui <- page_fluid(
  
  use_telemetry(),
  
  titlePanel(title=div(tags$a(href='https://linktr.ee/estacion_r',
                              tags$img(src='https://pbs.twimg.com/profile_banners/1214735980172845056/1716430021/600x200',
                                       height = 105, width = 300)), align = "center")),
  theme = bs_theme(
    primary = "#191919",
    bg = "white",
    fg = "#405BFF",
    secondary = "#EAFF38",
    success = "#405BFF",
    base_font = font_google("Ubuntu")
  ),
  
  # Redes sociales
  r2social.scripts(),
  shareButton(link = "https://estacionr.shinyapps.io/shiny_copa_america/", 
              position = "inline", plain = F,
              text = "¿Querés saber cómo viene la Copa América? Revisá esta aplicación, actualizate y compartó los últimos resultados del torneo",
              bg.col = "#EAFF38", 
              x = T,
              facebook = T,
              linkedin = T,
              tiktok = T, 
              whatsapp = T, 
              telegram = T
  ),
  
  # Paneles de la app
  navset_underline(
  
  # Calendario
    nav_panel(
      
      title = "Calendario",
      br(),
      
      fluidRow(
        calendarOutput("my_calendar")
        )
    ),
  
  # Resultados
  nav_panel(
    title = "Resultados",
    br(),
    br(),
    bracketsViewerOutput("c_america"),
    br(),
    textOutput("clicked_match2")
  )
)
)


server <- function(input, output, session) {
  telemetry$start_session() # 3. Minimal setup to track events
  
  # Calendario
  output$my_calendar <- renderCalendar({
    calendar(
      navigation = TRUE,
      navOpts = navigation_options(
        today_label = "Hoy",
        class = "bttn-stretch bttn-sm bttn-warning",
        color = "#50535C", 
        fmt_date = format("MM/YYYY"),
        sep_date = "-"
      )
    ) %>%
      cal_schedules(
        df_calendario
      ) %>% 
      cal_month_options(
        startDayOfWeek = 1,
        daynames = 
          #c("Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"),
          c("D", "L", "M", "M", "J", "V", "S"),
        narrowWeekend = TRUE,
        isAlways6Week = F
      ) %>%
      cal_props(
        id = 123,
        color = "#405BFF", #cian
        bgColor = "white",
        borderColor = "#EAFF38" #rosa
      )
})

  # Resultados
  output$c_america <- renderBracketsViewer({
    bracketsViewer(
      data = df_copa_america
    )
  })
  
  output$clicked_match2 <- renderText({
    input$soccer_match_click
  })
  
}

shinyApp(ui = ui, server = server)
