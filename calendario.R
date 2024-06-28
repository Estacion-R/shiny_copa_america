
library(googlesheets4)
library(tidyverse)
#devtools::install_version("toastui", version = "0.2.1", repos = "http://cran.us.r-project.org", quiet = T)
library(tidyverse)
library(toastui)

### Importar calendario fuente
# Desactivo pedido de acceso
googlesheets4::gs4_deauth()

path <- "https://docs.google.com/spreadsheets/d/1g6IrRbCKKIQmH5fctOAw2Nu-gP-IKn42ak-eCytjFZM/edit?gid=0#gid=0"

# Traigo base de calendario
hrs <- 3 * 60 * 60 
df_calendario <- googlesheets4::read_sheet(path) |> 
  mutate(start = start + hrs)


### Armo calendario
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


calendar() %>%
  cal_schedules(
    title = "R - introduction",
    body = "What is R?",
    start = format(Sys.Date(), "%Y-%m-03 08:00:00"),
    end = format(Sys.Date(), "%Y-%m-03 12:00:00"),
    category = "time"
  ) %>%
  cal_schedules(
    title = "R - visualisation",
    body = "With ggplot2",
    start = format(Sys.Date(), "%Y-%m-05 08:00:00"),
    end = format(Sys.Date(), "%Y-%m-05 12:00:00"),
    category = "time"
  ) %>%
  cal_schedules(
    title = "Build first package",
    body = "Build first package",
    start = format(Sys.Date(), "%Y-%m-12"),
    end = format(Sys.Date(), "%Y-%m-18"),
    category = "allday"
  ) %>%
  cal_schedules(
    title = "Lunch",
    body = "With friends",
    start = format(Sys.Date(), "%Y-%m-15 12:00:00"),
    end = format(Sys.Date(), "%Y-%m-15 14:00:00"),
    category = "time"
  )
