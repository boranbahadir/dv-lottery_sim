require 'tk'


$pencere = TkRoot.new { title "DV Lottery"; geometry "2560x1440" }


background_image = TkPhotoImage.new(file: 'background_image.gif')
background_label = TkLabel.new($pencere) do
  image background_image
  place('x' => 0, 'y' => 0, 'relwidth' => 1, 'relheight' => 1)
end



def kullanici_girisi
  $kullanici_girisi_cerceve = TkFrame.new($pencere)
  $isim_etiketi = TkLabel.new($kullanici_girisi_cerceve) { text "İsim:" }.pack('side' => 'left')
  $isim_giris = TkEntry.new($kullanici_girisi_cerceve).pack('side' => 'left')
  $soyisim_etiketi = TkLabel.new($kullanici_girisi_cerceve) { text "Soyisim:" }.pack('side' => 'left')
  $soyisim_giris = TkEntry.new($kullanici_girisi_cerceve).pack('side' => 'left')
  TkButton.new($kullanici_girisi_cerceve) do
    text "Giriş Yap"
    command proc { isim_ekrani($isim_giris.value, $soyisim_giris.value) }
  end.pack('side' => 'left')
  $kullanici_girisi_cerceve.pack
end

def isim_ekrani(isim, soyisim)
  $kullanici_girisi_cerceve.destroy
  TkLabel.new($pencere) { text "Hoş geldiniz #{isim} #{soyisim}" }.pack
  TkButton.new($pencere) { text "Çekiliş Sonucunu Göster"; command { cekilis_ekrani(isim) } }.pack
end


def cekilis_ekrani(isim)
  if defined?($cekilis_widgetler)
    $cekilis_widgetler.each(&:destroy)
    $cekilis_widgetler.clear
  else
    $cekilis_widgetler = []
  end


  sonuc = rand(100) == 0 ? "Tebrikler! Ekranı kazandınız!" : "Üzgünüz, bu sefer kazanamadınız."
  sonuc_label = TkLabel.new($pencere) { text sonuc }.pack
  $cekilis_widgetler << sonuc_label


  $tekrar_giris_butonu.pack_forget if defined?($tekrar_giris_butonu)
end

kullanici_girisi

Tk.mainloop
