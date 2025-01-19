# Load necessary libraries
library(scales)
library(colorspace)
library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(markdown)
library(dplyr)
library(ggplot2)
library(leaflet)
library(bs4Dash)
library(bslib)
library(terra)

# Define UI
my_theme <- bs_theme(
  bg = "#202123", fg = "#B8BCC2", primary = "#EA80FC",
  base_font = font_google("Grandstander"),
  "font-size-base" = "1.1rem"
)

# Define UI
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(
    title = tags$div(
      style = "background-color: #007bff; padding: 8px; text-align: center;",
      tags$img(src = "https://u3xfr2-mutiara-afriansa0pramesti.shinyapps.io/carbonara/_w_7c1ca104/Logo%20Carbonator.png", 
               height = "50px", 
               style = "margin-right: 10px; vertical-align: middle;"),
      tags$span("Carbonator", style = "font-weight:bold; font-size:1.5em; color: white;")
    )
  ),
  dashboardSidebar(
    sidebarMenu(id = "tabs",  # Tambahkan ID untuk sidebarMenu
                menuItem("Informasi", tabName = "tujuan", icon = icon("info")),
                menuItem("Input Data", tabName = "input_data", icon = icon("edit")),
                menuItem("Hasil", tabName = "hasil", icon = icon("bar-chart")),
                menuItem("Metode Pembayaran", tabName = "metode_pembayaran", icon = icon("credit-card"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tujuan",
              fluidRow(
                box(title = "Perhitungan Pajak Karbon: Menuju Indonesia Bebas Emisi 2060", status = "primary", solidHeader = TRUE, width = 12,
                    tags$br(),
                    tags$img(src="https://assets-a1.kompasiana.com/items/album/2024/01/30/zero-carbon-65b8f31dc57afb49dc603772.jpg", height = "300px", style = "display: block; margin-left: auto; margin-right: auto;"),
                    tags$br(),
                    tags$br(),
                    h3("Latar Belakang dan Tujuan", style ="font-weight:bold;"),
                    tags$p("Emisi gas rumah kaca, terutama karbon dioksida (CO2), merupakan penyebab utama perubahan iklim. Aktivitas industri, seperti pembakaran bahan bakar fosil dan proses manufaktur, memberikan kontribusi signifikan terhadap emisi karbon. Dari tahun 2010 hingga 2018, emisi gas rumah kaca (GRK) nasional menunjukkan tren kenaikan sekitar 4,3% per tahun. 
                            Untuk mengatasi masalah ini, pemerintah Indonesia telah menerapkan berbagai kebijakan, salah satunya adalah Undang-Undang Nomor 7 Tahun 2021 tentang Harmonisasi Perpajakan (UU HPP), yang memperkenalkan skema Pajak Karbon. Pajak Karbon adalah instrumen ekonomi yang bertujuan mendorong pengurangan emisi karbon dan mendukung pencapaian target emisi nol bersih (net-zero emission) pada tahun 2060. Selain itu, Peraturan Presiden Nomor 98 Tahun 2021 tentang Penyelenggaraan Nilai Ekonomi Karbon (NEK) - Pasal 5 juga menetapkan pungutan atas karbon sebagai pungutan negara, baik di pusat maupun daerah, berdasarkan kandungan karbon, potensi emisi karbon, jumlah emisi karbon, dan kinerja aksi mitigasi. 
                            Namun, perhitungan Pajak Karbon tidaklah sederhana. Proses ini melibatkan berbagai faktor seperti jenis industri, jumlah emisi karbon yang dihasilkan, dan metode pengukuran emisi, yang membuatnya rumit dan memakan waktu bagi industri.", style = "text-align:justify;"),
                    tags$p("Berikut ini adalah tujuan dari pembuatan aplikasi perhitungan pajak karbon:"),
                    tags$ol(
                      tags$li("Aplikasi ini dirancang untuk membantu industri dalam memantau dan mengelola data emisi karbon mereka dengan lebih efektif dan efisien."),
                      tags$li("Dengan kalkulator Pajak Karbon yang terintegrasi, aplikasi ini akan memudahkan industri dalam menghitung dan membayar pajak karbon sesuai dengan peraturan yang berlaku."),
                      tags$li("Aplikasi ini bertujuan untuk meningkatkan kepatuhan pajak perusahaan dengan menyediakan alat yang mudah digunakan untuk perhitungan dan pelaporan pajak karbon."),
                      tags$li("Melalui pemantauan yang teratur dan pelaporan yang transparan, aplikasi ini diharapkan dapat meningkatkan kesadaran industri terhadap emisi karbon yang dihasilkan."),
                      tags$li("Selain mengelola data emisi, aplikasi ini juga berfungsi sebagai alat edukasi untuk meningkatkan kesadaran mengenai dampak lingkungan dari aktivitas industri."),
                      tags$li("Dengan fitur pelaporan yang transparan, aplikasi ini akan membantu perusahaan dalam memberikan informasi yang akurat dan terpercaya mengenai emisi karbon dan pembayaran pajak karbon mereka."),
                      tags$li("Aplikasi Kalkulator Pajak Karbon ini merupakan kontribusi positif dalam mendukung upaya nasional untuk mengurangi emisi gas rumah kaca dan mencapai target emisi nol bersih (net-zero emission) pada tahun 2060.", style = "text-align:justify;")
                    ),
                    p("Isikan Data dengan Jujur dan Benar!", style = "font-weight:bold;color:red;",style = "text-align:center;"),
                    tags$br(),
                    tags$p("Presented by: ", style = "font-weight:bold"),
                    tags$img(src = "https://c8.alamy.com/comp/2DBXR08/ceteris-paribus-text-concept-closeup-american-dollars-cash-money3d-rendering-ceteris-paribus-at-dollar-banknote-financial-usa-money-banknote-comme-2DBXR08.jpg", height = "200px", style = "margin-center: px;"
                    ),
                    tags$br(),
                    tags$br(),
                    actionButton("input_data", "Input Data")
                )
              )
      ),
      tabItem(tabName = "input_data",
              fluidRow(
                box(title = "Input Data dan Petunjuk Pengisian", status = "primary", solidHeader = TRUE, width = 12,
                    tags$div(
                      h4("Petunjuk Pengisian Aplikasi Kalkulator Pajak Karbon:", style = "font-weight:bold"),
                      tags$ol(
                        tags$li("Isikan data perusahaan dan data produksi listrik sesuai dengan informasi yang valid."),
                        tags$li("Pastikan untuk memilih tahun yang sesuai."),
                        tags$li("Isikan kapasitas pembangkit listrik dalam MWh (megawatt-hour)."),
                        tags$li("Produksi listrik bruto harus diisi dalam MWh (megawatt-hour)."),
                        tags$li("Surat Izin Emisi (SIE) harus diisi dalam ton CO2e (ton karbon dioksida setara).")
                      )
                    ),
                    textInput("nama_perusahaan", "Nama Perusahaan"),
                    selectInput("tahun", "Tahun", choices = as.character(2020:2025)),
                    numericInput("kapasitas_pembangkit", "Kapasitas Pembangkit (MwH)", value = 0),
                    numericInput("produksi_listrik_bruto", "Produksi Listrik Bruto (MwH)", value = 0),
                    numericInput("sie", "Surat Izin Emisi (SIE) (ton CO2e)", value = 0),
                    actionButton("process","Process"),
                    actionButton("go_to_results", "Go to Results")
                )
              )
      ),
      
      tabItem(tabName = "hasil",
              fluidRow(
                box(title = "Data Pajak Karbon", status = "primary", solidHeader = TRUE, width = 12,
                    tableOutput("data_table")
                ),
                box(title = "Data Perhitungan Pajak Karbon", status = "primary", solidHeader = TRUE, width = 12,
                    tableOutput("detail_table")
                ),
                box(title = "Jumlah Pajak Karbon", status = "primary", solidHeader = TRUE, width = 12,
                    verbatimTextOutput("pajak_karbon_final")
                ),
                box(title = "Bar Chart Pajak Karbon", status = "primary", solidHeader = TRUE, width = 12,
                    plotOutput("carbon_tax_plot")
                ),
                box(title = "Bar Chart Emisi Karbon", status = "primary", solidHeader = TRUE, width = 12,
                    plotOutput("carbon_emissions_plot")
                ),
                actionButton("go_to_payment", "Go to Payment"),  # Tambahkan button untuk pindah ke tab Metode Pembayaran
                actionButton("go_to_dashboard", "Go to Dashboard")  # Tambahkan button untuk pindah ke tab Input Data
              )
      ),
      tabItem(tabName = "metode_pembayaran",
              fluidRow(
                box(title = "Metode Pembayaran", status = "primary", solidHeader = TRUE, width = 12,
                    selectInput("metode_pembayaran", "Metode Pembayaran", choices = c("m-banking", "ATM")),
                    fileInput("bukti_pembayaran", "Unggah Bukti Pembayaran", accept = c(".jpg", ".png", ".pdf")),
                    actionButton("submit_payment", "Submit Payment"),  # Tombol untuk submit pembayaran
                    actionButton("go_to_results_from_payment", "Go to Results"),  # Tambahkan button untuk pindah ke tab Hasil
                    actionButton("go_to_dashboard_from_payment", "Go to Dashboard"),
                    tags$br(), tags$br(),
                    box(title= "Notifikasi", status = "primary", solidHeader = TRUE, width = 12, verbatimTextOutput("thank_u"))
                )
              )
      )
    )
  )
)


server <- function(input, output, session) {
  data <- eventReactive(input$process, {
    # 1. Input data user
    df <- data.frame(
      nama_perusahaan = input$nama_perusahaan,
      tahun = as.numeric(input$tahun),
      kapasitas_pembangkit = input$kapasitas_pembangkit,
      produksi_listrik_bruto = input$produksi_listrik_bruto,
      sie = input$sie,
      stringsAsFactors = FALSE
    )
    
    # Constants
    cap_emisi <- 0.918 # CO2e/MwH
    total_emisi_grk <- 5800000 # ton CO2e yang ditentukan pemerintah
    tarif_pajak <- 30000 # Rp/ton CO2e
    
    # 2. Menghitung variabel total emisi yang dikeluarkan perusahaan
    df <- df %>%
      mutate(total_emisi = cap_emisi * produksi_listrik_bruto) %>%
      mutate(surplus_defisit_karbon = total_emisi - total_emisi_grk) %>%
      mutate(melebihi_batas = surplus_defisit_karbon <0) %>%
      mutate(dpp = ifelse(melebihi_batas, surplus_defisit_karbon * -1 , 0)) %>%
      mutate(pajak_karbon = dpp * tarif_pajak) %>%
      mutate(pengurangan_pajak = sie * tarif_pajak) %>%
      mutate(pajak_karbon_final = ifelse(melebihi_batas, pajak_karbon - pengurangan_pajak, 0))
    
    # Redirect to results tab
    updateTabItems(session, "tabs", "hasil")
    
    df
  })
  
  observeEvent(input$go_to_payment, {
    updateTabItems(session, "tabs", "metode_pembayaran")
  })
  
  observeEvent(input$input_data, {
    updateTabItems(session, "tabs", "input_data")
  })
  
  observeEvent(input$go_to_results, {
    updateTabItems(session, "tabs", "hasil")
  })
  
  observeEvent(input$go_to_results_from_payment, {
    updateTabItems(session, "tabs", "hasil")
  })
  
  observeEvent(input$go_to_dashboard_from_payment, {
    updateTabItems(session, "tabs", "input_data")
  })
  
  observeEvent(input$go_to_dashboard, {
    updateTabItems(session, "tabs", "input_data")
  })
  
  observeEvent(input$submit_payment, {
    output$thank_u <- renderText({
      "Terima Kasih! Pembayaran Anda telah berhasil diproses."
    })
  })
  
  output$data_table <- renderTable({
    req(data())
    data() %>%
      select(-pajak_karbon_final, -surplus_defisit_karbon, -melebihi_batas, -dpp, -pajak_karbon, -pengurangan_pajak)
  })
  
  output$pajak_karbon_final <- renderPrint({
    req(data())
    total_pajak <- sum(data()$pajak_karbon_final, na.rm = TRUE)
    formatted_total <- scales::dollar_format(prefix = "Rp ", big.mark = ".", decimal.mark = ",")(total_pajak)
    paste("Total Pajak Karbon yang Harus Dibayar:", formatted_total)
  })
  
  output$carbon_tax_plot <- renderPlot({
    req(data())
    ggplot(data(), aes(x = as.factor(tahun), y = pajak_karbon_final)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(title = "Penerimaan Pajak Karbon per Tahun",
           x = "Tahun",
           y = "Penerimaan Pajak Karbon (Rp)") +
      scale_y_continuous(labels = scales::dollar_format(prefix = "Rp ", big.mark = ".", decimal.mark = ","))
  })
  
  output$carbon_emissions_plot <- renderPlot({
    req(data())
    ggplot(data(), aes(x = as.factor(tahun), y = total_emisi)) +
      geom_bar(stat = "identity", fill = "orange") +
      labs(title = "Jumlah Emisi Karbon per Tahun",
           x = "Tahun",
           y = "Total Emisi Karbon (ton CO2e)")
  })
  output$detail_table <- renderTable({
    req(data())
    data() %>%
      select(pajak_karbon_final, surplus_defisit_karbon, melebihi_batas, dpp, pajak_karbon, pengurangan_pajak)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

