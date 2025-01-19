### Rizal Pangestu ###
### 21/481585/EK/23658 ###
### UTS R Programming ###


# 1. Fungsi membaca data eksternal dari file excel
install.packages("readxl")
library(readxl)

data_penjualan <- read_excel("C:\\Users\\ACER\\OneDrive - UGM 365\\Documents\\Semester 6\\R Programming\\UTS\\bea_masuk_atk.xlsx", sheet = "Sheet1")
View(data_penjualan)

#2.Membuat vektor kurs USD/IDR
kurs_rupiah <- c(15504, 15685, 15710, 15710, 15655, 15775, 15775, 15775, 15795, 15785, 15850, 15850, 15880,
                 15880, 15880, 15885, 15850, 15850, 15880, 15885, 15895, 15915, 15890, 15840, 15840, 15840,
                 15925, 15899, 15998, 16031, 16117, 16116, 16170, 16215, 16170, 16250, 16230, 16215, 16150, 
                 16185, 16241, 16126)
cat("Kurs Beli IDR/USD Periode 17/03/2024-27/04/2024: ", kurs_rupiah, "\n")


# Mengonversikan harga barang dalam dollar AS ke rupiah kemudian menggabungkan ke data file excel sebelumnya
data_penjualan$total_dalam_rupiah <- data_penjualan$total * kurs_rupiah
View(data_penjualan)

#3. Print harga barang dalam Rupiah
print(data_penjualan)

#4. Penentuan HS Code pada Bea Masuk
HS_code_vektor <-  c("42021110", "39261000", "96099010", "46021110", "43040091", "46021110", "49010000", "39269081", "90172010", "96083020", "82130000",
                     "42021110", "39261000", "96099010", "46021110", "43040091", "46021110", "49010000", "39269081", "90172010", "96083020", "82130000",
                     "42021110", "39261000", "96099010", "46021110", "43040091", "46021110", "49010000", "39269081", "90172010", "96083020", "82130000",
                     "42021110", "39261000", "96099010", "46021110", "43040091", "46021110", "49010000", "96083020", "82130000")

tarif_bea_impor <- NA

for (i in 1:length(HS_code_vektor)) {
  hs_code_i <- HS_code_vektor[i]
  
  if (hs_code_i == "42021110") {
    data_penjualan$tarif_bea_masuk[i] <- 0.15
  } else if (hs_code_i == "39261000") {
    data_penjualan$tarif_bea_masuk[i] <- 0.15
  } else if (hs_code_i == "96099010") {
    data_penjualan$tarif_bea_masuk[i] <- 0.05
  } else if (hs_code_i == "46021110") {
    data_penjualan$tarif_bea_masuk[i] <- 0.00
  } else if (hs_code_i == "43040091") {
    data_penjualan$tarif_bea_masuk[i] <- 0.20
  } else if (hs_code_i == "49010000") {
    data_penjualan$tarif_bea_masuk[i] <- 0.00
  } else if (hs_code_i == "39269081") {
    data_penjualan$tarif_bea_masuk[i] <- 0.20
  } else if (hs_code_i == "90172010") {
    data_penjualan$tarif_bea_masuk[i] <- 0.10
  } else if (hs_code_i == "96083020") {
    data_penjualan$tarif_bea_masuk[i] <- 0.10
  } else if (hs_code_i == "82130000") {
    data_penjualan$tarif_bea_masuk[i] <- 0.10
  } else {
    print("NA")
  }
}
View(data_penjualan) #Tarif bea masuk sudah terinput ke dalam tabel

#5. Kalikan Harga Barang dalam Rupiah dengan Tarif Bea Masuk sesuai dengan Penentuan HS Code sebelumnya sehingga menjadi Beban Bea Masuk
data_penjualan$beban_bea_masuk <- data_penjualan$total_dalam_rupiah * data_penjualan$tarif_bea_masuk
View(data_penjualan) #Beban bea masuk sudah terinput ke dalam tabel

#6. Print Beban Tarif Bea Masuk
cat("Beban Bea Masuk sebesar: ", data_penjualan$beban_bea_masuk, "\n")

#7. Tambahkan Harga Barang dengan Beban Tarif Bea Masuk sehingga menjadi Total Nilai Impor Kena Bea Masuk
data_penjualan$total_nilai_impor_kena_bea_masuk <- data_penjualan$total_dalam_rupiah + data_penjualan$beban_bea_masuk
print(data_penjualan$total_nilai_impor_kena_bea_masuk)
View(data_penjualan) #Total Nilai Impor Kena Bea Masuk sudah terinput ke dalam tabel

#8.Print Total Nilai Impor Kena Bea Masuk
cat("Total Nilai Impor Kena Bea Masuk sebesar: ", data_penjualan$total_nilai_impor_kena_bea_masuk, "\n")

#9 Penentuan Tarif PPN dan PPh 22
#Tarif PPN
tarif_ppn_dummy <- NA

for (i in 1:length(HS_code_vektor)) {
  hs_code_i <- HS_code_vektor[i]
  
  if (hs_code_i == "42021110") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "39261000") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "96099010") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "46021110") {
    data_penjualan$tarif_ppn[i] <- 0.00
  } else if (hs_code_i == "43040091") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "49010000") {
    data_penjualan$tarif_ppn[i] <- 0.00
  } else if (hs_code_i == "39269081") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "90172010") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "96083020") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else if (hs_code_i == "82130000") {
    data_penjualan$tarif_ppn[i] <- 0.11
  } else {
    print("NA")
  }
}
View(data_penjualan) #Tarif PPN sudah terinput ke dalam tabel

#Tarif PPh 22
tarif_pph_dummy <- NA

for (i in 1:length(HS_code_vektor)) {
  hs_code_i <- HS_code_vektor[i]
  
  if (hs_code_i == "42021110") {
    data_penjualan$tarif_pph[i] <- 0.10
  } else if (hs_code_i == "39261000") {
    data_penjualan$tarif_pph[i] <- 0.025
  } else if (hs_code_i == "96099010") {
    data_penjualan$tarif_pph[i] <- 0.025
  } else if (hs_code_i == "46021110") {
    data_penjualan$tarif_pph[i] <- 0.00
  } else if (hs_code_i == "43040091") {
    data_penjualan$tarif_pph[i] <- 0.075
  } else if (hs_code_i == "49010000") {
    data_penjualan$tarif_pph[i] <- 0.025
  } else if (hs_code_i == "39269081") {
    data_penjualan$tarif_pph[i] <- 0.075
  } else if (hs_code_i == "90172010") {
    data_penjualan$tarif_pph[i] <- 0.025
  } else if (hs_code_i == "96083020") {
    data_penjualan$tarif_ppn[i] <- 0.025
  } else if (hs_code_i == "82130000") {
    data_penjualan$tarif_ppn[i] <- 0.025
  } else {
    print("NA")
  }
}
View(data_penjualan) #Tarif PPh 22 sudah terinput ke dalam tabel

#10. Kalikan Harga Barang dalam Rupiah dengan Tarif PPN dan PPh 22 sesuai HS Code yang Telah Ditentukan Sebelumnya sehingga Menjadi Beban PPN dan PPh 22
data_penjualan$beban_ppn <- data_penjualan$total_dalam_rupiah * data_penjualan$tarif_ppn
View(data_penjualan) #Beban PPN sudah terinput ke dalam tabel
data_penjualan$beban_pph <- data_penjualan$total_dalam_rupiah * data_penjualan$tarif_pph
View(data_penjualan) #Beban PPh 22 sudah terinput ke dalam tabel

#11. Print Beban PPN dan PPh 22
cat("Beban PPN sebesar: ", data_penjualan$beban_ppn, "\n")
cat("Beban PPh 22 sebesar: ", data_penjualan$beban_pph, "\n")

#12. Tambahkan Beban Bea Masuk, PPN, dan PPh 22 sehingga Menjadi Pungutan Impor
data_penjualan$pungutan_impor <- data_penjualan$beban_bea_masuk + data_penjualan$beban_ppn + data_penjualan$beban_pph
View(data_penjualan) #Kolom Pungutan Impor Sudah Terinput ke Dalam Tabel

#13. Tambahkan Pungutan Impor dengan Harga Barang sehingga Menjadi Total yang Harus Dibayarkan
data_penjualan$total_yang_harus_dibayarkan <- data_penjualan$pungutan_impor + data_penjualan$total_dalam_rupiah
View(data_penjualan) #Kolom Total yang Harus Dibayarkan Sudah Terinput ke Dalam Tabel

#14. Print Total yang Harus Dibayarkan
cat("Total yang Harus Dibayarkan:", data_penjualan$total_yang_harus_dibayarkan, "\n")

#15. Grand Total dari Total yang Harus Dibayarkan
total_pembayaran_impor_atk <- sum(data_penjualan$total_yang_harus_dibayarkan)

#16. Print Total Pembayaran Impor
cat("Total Pembayaran Impor:", "Rp", total_pembayaran_impor_atk, "\n")

#17.Mengekstrak Tabel yang Telah Dibuat Menjadi Sebuah File Excel
install.packages("writexl")
library(writexl)
write_xlsx(data_penjualan, "C:\\Users\\ACER\\OneDrive - UGM 365\\Documents\\Semester 6\\R Programming\\UTS\\data_penjualan.xlsx")
