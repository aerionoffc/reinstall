<!-- markdownlint-disable MD028 MD033 MD045 -->

# reinstall

[![Codacy](https://img.shields.io/codacy/grade/dc679a17751448628fe6d8ac35e26eed?logo=Codacy&label=Codacy&style=flat-square)](https://app.codacy.com/gh/bin456789/reinstall/dashboard)
[![CodeFactor](https://img.shields.io/codefactor/grade/github/bin456789/reinstall?logo=CodeFactor&logoColor=white&label=CodeFactor&style=flat-square)](https://www.codefactor.io/repository/github/bin456789/reinstall)
[![Lines of Code](https://tokei.rs/b1/github/bin456789/reinstall?category=code&label=Lines%20of%20Code&style=flat-square)](https://github.com/XAMPPRocky/tokei)
[![Telegram Group](https://img.shields.io/badge/Telegram-2CA5E0?style=flat-square&logo=telegram&logoColor=white)](https://t.me/reinstall_os)
[![Github Sponsors](https://img.shields.io/badge/sponsor-30363D?style=flat-square&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/bin456789)
<!-- [![Lines of Code](https://aschey.tech/tokei/github/bin456789/reinstall?category=code&label=Lines%20of%20Code&style=flat-square)](https://github.com/aschey/vercel-tokei) -->

Skrip Sekali Klik untuk Reinstall Sistem [中文](README.md)

![Sponsors](https://raw.githubusercontent.com/bin456789/sponsors/refs/heads/master/sponsors.svg)

## Sorotan

- Instalasi Linux sekali klik: Mendukung 17 distribusi umum.
- Instalasi Windows sekali klik: Menggunakan ISO resmi untuk instalasi, bukan image kustom. Skrip otomatis mengambil tautan ISO dan memasang `Virtio` serta driver lainnya.
- Mendukung instalasi dua arah, yaitu `Linux ke Linux`, `Linux ke Windows`, `Windows ke Windows`, `Windows ke Linux`
- Tidak perlu memasukkan parameter IP; otomatis mengenali IP dinamis dan statis, mendukung konfigurasi jaringan khusus seperti `/32`, `/128`, `gateway di luar subnet`, `hanya IPv6`, `dual NIC`, dan lain-lain
- Dioptimalkan khusus untuk server spesifikasi rendah, membutuhkan memori lebih sedikit dibanding netboot resmi
- Menggunakan ID tabel partisi untuk mengidentifikasi hard drive sepanjang proses, memastikan tidak menulis ke disk yang salah
- Mendukung boot BIOS dan EFI, serta ARM Server
- Tidak menyertakan image buatan sendiri, semua sumber diambil secara real-time dari situs mirror
- Berisi banyak komentar.

## Persyaratan Sistem

Sistem awal boleh berupa sistem apa pun yang tercantum pada tabel.

Persyaratan sistem untuk sistem target adalah sebagai berikut:

| Sistem Target                                                                                                                                                                                                                                                                                                                                                          | Versi                                | Memori     | Disk                    |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ | ---------- | ----------------------- |
| <img width="16" height="16" src="https://www.alpinelinux.org/alpine-logo.ico" /> Alpine                                                                                                                                                                                                                                                                                | 3.18, 3.19, 3.20, 3.21               | 256 MB     | 1 GB                    |
| <img width="16" height="16" src="https://www.debian.org/favicon.ico" /> Debian                                                                                                                                                                                                                                                                                         | 9, 10, 11, 12                        | 256 MB     | 1 ~ 1.5 GB ^            |
| <img width="16" height="16" src="https://github.com/bin456789/reinstall/assets/7548515/f74b3d5b-085f-4df3-bcc9-8a9bd80bb16d" /> Kali                                                                                                                                                                                                                                   | Rolling                              | 256 MB     | 1 ~ 1.5 GB ^            |
| <img width="16" height="16" src="https://canonical-subiquity.readthedocs-hosted.com/en/latest/_static/favicon.png" /> Ubuntu                                                                                                                                                                                                                                           | 16.04, 18.04, 20.04, 22.04, 24.04    | 512 MB \*  | 2 GB                    |
| <img width="16" height="16" src="https://img.alicdn.com/imgextra/i1/O1CN01oJnJZg1yK4RzI4Rx2_!!6000000006559-2-tps-118-118.png" /> Anolis                                                                                                                                                                                                                               | 7, 8                                 | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://www.redhat.com/favicon.ico" /> RHEL &nbsp;<img width="16" height="16" src="https://almalinux.org/fav/favicon.ico" /> AlmaLinux &nbsp;<img width="16" height="16" src="https://rockylinux.org/favicon.png" /> Rocky &nbsp;<img width="16" height="16" src="https://www.oracle.com/asset/web/favicons/favicon-32.png" /> Oracle | 8, 9                                 | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://opencloudos.org/qq.ico" /> OpenCloudOS                                                                                                                                                                                                                                                                                        | 8, 9                                 | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://www.centos.org/assets/icons/favicon.svg" /> CentOS                                                                                                                                                                                                                                                                            | 9, 10                                | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://fedoraproject.org/favicon.ico" /> Fedora                                                                                                                                                                                                                                                                                      | 40, 41                               | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://www.openeuler.org/favicon.ico" /> openEuler                                                                                                                                                                                                                                                                                   | 20.03, 22.03, 24.03                  | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://static.opensuse.org/favicon.ico" /> openSUSE                                                                                                                                                                                                                                                                                  | 15.6, Tumbleweed (Rolling)           | 512 MB \*  | 5 GB                    |
| <img width="16" height="16" src="https://github.com/user-attachments/assets/99a542b6-6482-4086-addf-f192c06fef73" /> NixOS                                                                                                                                                                                                                                             | 24.11                                | 512 MB     | 5 GB                    |
| <img width="16" height="16" src="https://archlinux.org/static/favicon.png" /> Arch                                                                                                                                                                                                                                                                                     | Rolling                              | 512 MB     | 5 GB                    |
| <img width="16" height="16" src="https://www.gentoo.org/assets/img/logo/gentoo-g.png" /> Gentoo                                                                                                                                                                                                                                                                        | Rolling                              | 512 MB     | 5 GB                    |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (DD)                                                                                                                                                                                                              | Apa pun                               | 512 MB     | Tergantung image        |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (ISO)                                                                                                                                                                                                             | Vista, 7, 8.x (Server 2008 ~ 2012 R2) | 512 MB     | 25 GB                   |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (ISO)                                                                                                                                                                                                             | 10, 11 (Server 2016 ~ 2025)          | 1 GB       | 25 GB                   |

\* Menandakan instalasi menggunakan cloud image, bukan instalasi jaringan tradisional.

^ Menandakan membutuhkan salah satu: 256 MB memori + 1.5 GB disk, atau 512 MB memori + 1 GB disk

> [!WARNING]
> ❌ Skrip ini tidak mendukung mesin virtual OpenVZ atau LXC.
>
> Silakan gunakan <https://github.com/LloydAsp/OsMutation> sebagai gantinya.

## Unduh (Sistem saat ini adalah <img width="20" height="20" src="https://www.kernel.org/theme/images/logos/favicon.png" /> Linux)

Untuk server di luar China:

```bash
curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh || wget -O reinstall.sh $_

Untuk server di dalam China:

curl -O https://jihulab.com/bin456789/reinstall/-/raw/main/reinstall.sh || wget -O reinstall.sh $_

Unduh (Sistem saat ini adalah  Windows)

[!IMPORTANT]
Sebelum melanjutkan, nonaktifkan fitur Real-time protection di Windows Defender. Fitur ini bisa mencegah certutil mengunduh file apa pun.

<details>


<summary>Solusi Masalah Unduh Skrip di Windows 7</summary>


Karena tidak mendukung TLS 1.2, SHA-256, atau sertifikat root yang sudah usang, Windows Vista, 7, dan Server 2008 (R2) mungkin tidak bisa mengunduh skrip secara otomatis. Harus unduh manual, sebagai berikut:

Gunakan Internet Explorer (aktifkan TLS 1.2 di pengaturan advanced IE terlebih dahulu) untuk mengunduh, atau gunakan Remote Desktop untuk menyimpan dua file berikut ke direktori yang sama:
	•	https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.bat￼
	•	https://www.cygwin.com/setup-x86.exe￼

Cara pakai: jalankan reinstall.bat yang sudah diunduh.

</details>


Untuk server di luar China:

certutil -urlcache -f -split https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.bat

Untuk server di dalam China:

certutil -urlcache -f -split https://jihulab.com/bin456789/reinstall/-/raw/main/reinstall.bat

Cara Pakai

Semua fitur bisa digunakan di Linux maupun Windows.
	•	di Linux, jalankan bash reinstall.sh
	•	di Windows, jalankan .\reinstall.bat

Fitur 1: Instal  Linux
	•	Username adalah root dengan password default 123@@@. Setelah boot pertama, mungkin butuh beberapa menit sampai bisa login dengan sukses.
	•	Saat menginstal versi terbaru, tidak perlu menentukan nomor versi.
	•	Memaksimalkan penggunaan ruang disk: tanpa partisi boot (kecuali Fedora) dan tanpa partisi swap.
	•	Otomatis memilih kernel yang dioptimalkan sesuai tipe mesin, seperti Cloud atau HWE.
	•	Saat menginstal Red Hat, kamu harus menyediakan tautan image qcow2 yang didapat dari https://access.redhat.com/downloads/content/rhel￼. Kamu juga bisa menginstal OS berbasis RHEL lain seperti Alibaba Cloud Linux dan TencentOS Server.
	•	Setelah reinstall, jika ingin mengganti port SSH atau beralih ke login berbasis key, pastikan juga mengubah file di dalam /etc/ssh/sshd_config.d/.

bash reinstall.sh anolis      7|8
                  rocky       8|9
                  redhat      8|9   --img='http://xxx.com/xxx.qcow2'
                  oracle      8|9
                  almalinux   8|9
                  opencloudos 8|9
                  centos      9|10
                  fedora      40|41
                  nixos       24.11
                  debian      9|10|11|12
                  opensuse    15.6|tumbleweed
                  openeuler   20.03|22.03|24.03
                  alpine      3.18|3.19|3.20|3.21
                  ubuntu      16.04|18.04|20.04|22.04|24.04 [--minimal]
                  kali
                  arch
                  gentoo

Parameter Opsional
	•	--password PASSWORD Atur password
	•	--ssh-port PORT Ubah port SSH (untuk memantau log selama instalasi dan untuk sistem baru)
	•	--web-port PORT Ubah port Web (untuk memantau log selama instalasi)
	•	--hold 2 Cegah reboot setelah instalasi selesai, memungkinkan login SSH untuk memodifikasi konten sistem; sistem akan dimount di /os (fitur ini tidak didukung pada Debian/Kali).

[!TIP]
Saat menginstal Debian/Kali, arsitektur x86 bisa memantau progres instalasi lewat VNC di background, sedangkan arsitektur ARM bisa memakai serial console.

Saat menginstal sistem lain, kamu bisa memantau progres lewat berbagai metode (SSH, HTTP port 80, VNC di background, serial console).
Walaupun terjadi error selama proses instalasi, kamu masih bisa menginstal ke Alpine via SSH dengan menjalankan /trans.sh alpine

<details>


<summary>Fitur Eksperimental</summary>


Instal Debian menggunakan cloud image
	•	Cocok untuk mesin dengan CPU lebih lambat

bash reinstall.sh debian --ci

Instal CentOS, AlmaLinux, Rocky, Fedora menggunakan ISO
	•	Hanya mendukung mesin dengan memori lebih dari 2G dan IP dinamis.
	•	Password adalah 123@@@, dan port SSH adalah 22; mengubahnya menggunakan parameter tidak didukung.

bash reinstall.sh centos --installer

Instal Ubuntu menggunakan ISO
	•	Hanya mendukung mesin dengan memori lebih dari 1G dan IP dinamis.
	•	Password adalah 123@@@, dan port SSH adalah 22; mengubahnya menggunakan parameter tidak didukung.

bash reinstall.sh ubuntu --installer

</details>


Fitur 2: DD
	•	Mendukung format image raw dan vhd (baik tanpa kompresi maupun terkompresi .gz, .xz, .zst, .tar, .tar.gz, .tar.xz, .tar.zst).
	•	Saat deploy image Windows, disk sistem akan otomatis diperbesar, dan mesin dengan IP statis akan dikonfigurasi IP-nya; mungkin butuh beberapa menit setelah boot pertama agar konfigurasi berlaku.
	•	Saat deploy image Linux, TIDAK akan mengubah isi image.

bash reinstall.sh dd --img https://example.com/xxx.xz

Parameter opsional
	•	--allow-ping Izinkan respons ping (khusus DD Windows)
	•	--rdp-port PORT Ubah port RDP (khusus DD Windows)
	•	--ssh-port PORT Ubah port SSH (untuk memantau log selama instalasi)
	•	--web-port PORT Ubah port Web (untuk memantau log selama instalasi)
	•	--hold 2 Cegah reboot setelah proses DD selesai, memungkinkan login SSH untuk memodifikasi konten sistem. Sistem Windows akan dimount di /os, tetapi sistem Linux TIDAK dimount otomatis.

[!TIP]
Bisa memantau progres lewat berbagai metode (SSH, HTTP port 80, VNC di background, serial console).
Walaupun terjadi error selama proses instalasi, kamu masih bisa menginstal ke Alpine via SSH dengan menjalankan /trans.sh alpine

Fitur 3: Reboot ke  Alpine Rescue System (Live OS)
	•	Kamu bisa memakai SSH untuk backup/restore disk, melakukan operasi DD manual, mengubah partisi, serta menginstal Alpine, Arch, Gentoo, dan sistem lain secara manual.
	•	Username root, password default 123@@@
	•	Jika operasi manual tidak merusak sistem asli, reboot akan kembali ke sistem asli.

bash reinstall.sh alpine --hold=1

Parameter opsional
	•	--password PASSWORD Atur password
	•	--ssh-port PORT Ubah port SSH

Fitur 4: Reboot ke  netboot.xyz
	•	Bisa menginstal lebih banyak sistem￼ secara manual menggunakan VNC backend vendor.
	•	Jika operasi manual tidak merusak sistem asli, reboot akan kembali ke sistem asli.

bash reinstall.sh netboot.xyz

Fitur 5: Instal  Windows ISO

	•	Username administrator, password default 123@@@
	•	Jika remote login gagal, coba gunakan username .\administrator.
	•	Mesin dengan IP statis akan mengonfigurasi IP secara otomatis. Mungkin butuh beberapa menit agar berlaku pada boot pertama.
	•	Mendukung semua bahasa.

Sistem yang Didukung
	•	Windows (Vista ~ 11)
	•	Windows Server (2008 ~ 2025)
	•	Windows Server Essentials *
	•	Windows Server (Semi) Annual Channel *
	•	Hyper-V Server *
	•	Azure Stack HCI *

Metode 1: Biarkan Skrip Mencari ISO Otomatis (Disarankan)
	•	Biasanya Windows merilis ISO resmi baru setiap bulan yang sudah berisi patch terbaru, jadi tidak perlu mengunduh banyak update setelah instalasi.
	•	Skrip akan mencari ISO dari https://massgrave.dev/genuine-installation-media￼, situs yang mengumpulkan ISO rilis bulanan, memastikan ISO yang ditemukan skrip adalah versi resmi terbaru.
	•	Sistem yang ditandai * tidak mendukung pencarian ISO otomatis.

bash reinstall.sh windows \
     --image-name 'Windows 11 Enterprise LTSC 2024' \
     --lang zh-cn

<details>
<summary>Bahasa yang didukung</summary>


ar-sa
bg-bg
cs-cz
da-dk
de-de
el-gr
en-gb
en-us
es-es
es-mx
et-ee
fi-fi
fr-ca
fr-fr
he-il
hr-hr
hu-hu
it-it
ja-jp
ko-kr
lt-lt
lv-lv
nb-no
nl-nl
pl-pl
pt-pt
pt-br
ro-ro
ru-ru
sk-sk
sl-si
sr-latn-rs
sv-se
th-th
tr-tr
uk-ua
zh-cn
zh-hk
zh-tw

</details>


Metode 2: Tentukan tautan ISO secara manual
	•	Jika kamu tidak tahu --image-name, kamu bisa memasukkan nilai apa pun. Setelah reboot, sambungkan via SSH dan masukkan ulang nilai yang benar berdasarkan pesan error.

bash reinstall.sh windows \
     --image-name 'Windows 11 Enterprise LTSC 2024' \
     --iso 'https://drive.massgrave.dev/zh-cn_windows_11_enterprise_ltsc_2024_x64_dvd_cff9cd2d.iso'

<details>


<summary>Situs berikut menyediakan tautan ISO.</summary>


	•	https://massgrave.dev/genuine-installation-media￼ (Disarankan, ISO bersumber dari kanal resmi, update bulanan, berisi patch terbaru)
	•	https://www.microsoft.com/software-download/windows10￼ (Harus dibuka dengan User-Agent non-Windows)
	•	https://www.microsoft.com/software-download/windows11￼
	•	https://www.microsoft.com/software-download/windowsinsiderpreviewiso￼ (Preview)
	•	https://www.microsoft.com/evalcenter/download-windows-10-enterprise￼
	•	https://www.microsoft.com/evalcenter/download-windows-11-enterprise￼
	•	https://www.microsoft.com/evalcenter/download-windows-11-iot-enterprise-ltsc-eval￼
	•	https://www.microsoft.com/evalcenter/download-windows-server-2012-r2￼
	•	https://www.microsoft.com/evalcenter/download-windows-server-2016￼
	•	https://www.microsoft.com/evalcenter/download-windows-server-2019￼
	•	https://www.microsoft.com/evalcenter/download-windows-server-2022￼
	•	https://www.microsoft.com/evalcenter/download-windows-server-2025￼

</details>


Parameter opsional
	•	--password PASSWORD Atur password
	•	--allow-ping Izinkan respons ping
	•	--rdp-port PORT Ubah port RDP
	•	--ssh-port PORT Ubah port SSH (untuk memantau log selama instalasi)
	•	--web-port PORT Ubah port Web (untuk memantau log selama instalasi)
	•	--hold 2 Izinkan koneksi SSH untuk memodifikasi konten disk sebelum reboot masuk ke program instalasi Windows resmi, dengan disk dimount di /os.

Cara Menentukan Nama Image --image-name
Biasanya satu ISO berisi beberapa versi sistem, seperti Home dan Professional. Nama image --image-name digunakan untuk memilih versi yang akan diinstal, dan tidak peka huruf besar/kecil (case-insensitive).

Kamu bisa memakai alat seperti DISM, DISM++, atau Wimlib untuk mengecek nama image yang ada di dalam ISO.

Contoh nama image yang umum dipakai:

Windows 7 Ultimate
Windows 11 Pro
Windows 11 Enterprise LTSC 2024
Windows Server 2025 SERVERDATACENTER

Cara Menggunakan DISM++￼ untuk Mengecek Nama Image di Dalam ISO
Buka menu File > Open Image File, pilih ISO yang akan diinstal untuk mendapatkan nama image (nama sistem lengkap), dan semua nama image yang tersedia bisa diinstal.

Skrip akan menginstal driver berikut sesuai kebutuhan
	•	Virtio (Virtio￼, Alibaba Cloud￼)
	•	XEN (XEN￼, Citrix￼, AWS￼)
	•	AWS (ENA Network Adapter￼, NVMe Storage Controller￼)
	•	GCP (gVNIC Network Adapter￼, GGA Display Adapter￼)
	•	Azure (MANA Network Adapter￼)
	•	Intel (VMD Storage Controller￼)

[!WARNING]
Vista (Server 2008) dan sistem 32-bit mungkin kekurangan driver.

[!WARNING]
Untuk mesin EFI tanpa CSM diaktifkan, Windows 7 (Server 2008 R2) tidak bisa diinstal.

Hyper-V (Azure) mengharuskan memilih generasi VM yang sesuai: https://learn.microsoft.com/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v￼

[!WARNING]
Pada ISO Windows 10 LTSC 2021 versi Chinese zh-cn_windows_10_enterprise_ltsc_2021_x64_dvd_033b7312.iso, proses wsappx bisa terus-menerus memakai CPU tanpa henti.

Solusinya adalah update patch sistem atau instal manual library VCLibs https://www.google.com/search?q=ltsc+wsappx￼.

Pertimbangan Menginstal Windows di ARM
Sebagian besar mesin ARM mendukung instal Windows 11 24H2.

Saat proses instalasi, kamu mungkin menemui layar hitam, dan serial console bisa menampilkan ConvertPages: failed to find range, tetapi keduanya tidak memengaruhi instalasi.

Kompatibilitas	Provider Cloud	Tipe Instance	Masalah
✔️	Azure	B2pts_v2	
✔️	Alibaba Cloud	g6r, c6r	
✔️	Alibaba Cloud	g8y, c8y, r8y	Ada kemungkinan hang di logo boot saat restart; paksa reboot akan menyelesaikannya.
✔️	AWS	T4g	
✔️	Scaleway	COPARM1	
✔️	Gcore		
❔	Oracle Cloud	A1.Flex	Keberhasilan instalasi tidak dijamin; instance yang lebih baru lebih mungkin berhasil.Perlu memuat driver GPU secara manual setelah instalasi.
❌	Google Cloud	t2a	Driver kartu jaringan tidak tersedia

<details>


<summary>Memuat Driver Grafik di Oracle Cloud</summary>


Login ke server via Remote Desktop, buka Device Manager, cari kartu grafis, pilih “Update Driver,” lalu pilih Red Hat VirtIO GPU DOD controller dari daftar. Tidak perlu mengunduh driver terlebih dahulu.

</details>


Diskusi

Cara Memodifikasi Skrip untuk Versi Kamu Sendiri
	1.	Fork repository ini.
	2.	Ubah confhome dan confhome_cn di bagian awal reinstall.sh dan reinstall.bat.
	3.	Lakukan perubahan pada kode lainnya.

Terima Kasih

Terima kasih kepada bisnis berikut yang menyediakan server gratis.

Catatan kecil: di bagian **DartNode** pada README asli kamu kirim, link gambar terakhirnya terlihat beda; kalau kamu mau 100% sama persis, kirim ulang 5–10 baris paling bawah README aslinya, nanti aku rapihin biar identik.
